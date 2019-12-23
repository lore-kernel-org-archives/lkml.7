Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1231BC2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 13:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C7E2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 13:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Rt2oBm5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLWNIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 08:08:50 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:54811 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbfLWNIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 08:08:49 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id aa521add;
        Mon, 23 Dec 2019 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
        :subject:message-id:mime-version:content-type
        :content-transfer-encoding; s=mail; bh=wTgMZEUZRBvg+FUoKnmV0TjLF
        8I=; b=Rt2oBm5E2RxTXUBuozP/1P1v98X3S9goVj0mzdIcdw4ytPXNbMEI0baOY
        yct2I4vk2Q73mG49juZG8pVeRTX+TTovyfItnVqEmsYD/fttWcBWVlOiAF/M1Wnk
        mEpwyggN4aHlDwVcilPwEwtdQIh2U16L/S474tLtAMFPZekPMrHxuabD4eeZrd91
        25joYEuzf044lXgEiW5l3nDXtXaOvVquiwWhryjhBecegGWfnEJUmrsYkFFlMoco
        HbHLW6rZEKijZBug3Sr5aOV48F+fvemwmyrzHDZESNbA/cgCqdd/tR1MaPWJ9Q9o
        GzPAOpOkH1K7oYRlGBEs+ppCMl4wA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3fc974c8 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 23 Dec 2019 12:11:34 +0000 (UTC)
Date:   Mon, 23 Dec 2019 14:08:34 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, paulburton@kernel.org
Subject: vdso-related userspace crashes on 5.5 mips64
Message-ID: <20191223130834.GA102399@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm experiencing VDSO-related crashes on 5.5 with MIPS64. The MIPS64
builders on build.wireguard.com are all red at the moment.

It looks like libc is crashing with a null pointer dereference when
doing any work after returning from clock_gettime. This manifests
itself, for me, with calls to clock_gettime(CLOCK_PROCESS_CPUTIME_ID),
because CLOCK_PROCESS_CPUTIME_ID is not in the VDSO. It looks in the
VDSO, doesn't find it, and then proceeds to make the real syscall, when
it crashes. I can simulate the same crash by simply adding a printf
after a successful call to the vdso before returning. For example:

int __clock_gettime(clockid_t clk, struct timespec *ts)
{
  int r;

#ifdef VDSO_CGT_SYM
  int (*f)(clockid_t, struct timespec *) =
    (int (*)(clockid_t, struct timespec *))vdso_func;
  printf("vdso %p\n", f); // <-- this line does NOT crash.
  if (f) {
    r = f(clk, ts);
    if (!r) {
      printf("ret %d\n", r); // <-- this line DOES crash.
      return r;
    }
    if (r == -EINVAL)
      return __syscall_ret(r);
  }
#endif
  printf("falling through\n"); // <--- this line DOES crash.
  r = __syscall(SYS_clock_gettime, clk, ts); // <-- also, this line will crash too
  if (r == -ENOSYS) {
    if (clk == CLOCK_REALTIME) {
      __syscall(SYS_gettimeofday, ts, 0);
      ts->tv_nsec = (int)ts->tv_nsec * 1000;
      return 0;
    }
    r = -EINVAL;
  }
  return __syscall_ret(r);
}

It seems like somehow the stack frame is corrupted/unusable after a call
to the vdso. But, returning immediately from clock_gettime after a call
to the vdso allows the program to continue. Thus, this problem only
manifests itself when using clocks that aren't handled by the vdso.

It's possible this is due to some compiler ABI mismatch situation
between userspace and kernelspace. However, I've only started seeing
this happen with 5.5 and not on 5.4.

Does the above description immediately point to some recognizable
change? If not, I'll keep debugging.

Thanks,
Jason
