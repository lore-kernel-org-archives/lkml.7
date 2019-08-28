Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5763BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2002C22CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pWWEOSGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfH1PQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:16:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfH1PQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8K7w75RPW6v4R35r6JmgUfk3dHW0nTr/NpQB6sJf4qo=; b=pWWEOSGTyudk/6A10hR6Rlhjw
        A4Sphe4p05lJ/Hb8GVFUvYM1J6Jd9a+5Nsc4/cOPgWOGDKCeIMBRHYi6Is72mY5VWXV7d/+EG1nh7
        uMdv+ItX2xYd6/5PvNkTgEuRCp56CX+LySr6Y2AgZ87P4cmObrP9U0L15xxANZr/uKRJlC73WP6oX
        nMqlGIWRngHtKm7S+mfZ1p3YdpzPuTr+nyl8Ui4PbkslY7s+e1rS0bWwBeA+P4UY10THQRCzLRrwZ
        iWQDqh0cG3c0OqOwh53z3Tvoj/ml9ig9cP2h39LohZszaL18S5oYgdA1y/3trV8EeMZYE0eLe7Z5r
        OgCLEFGZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2zfs-0000aY-9Y; Wed, 28 Aug 2019 15:15:52 +0000
Date:   Wed, 28 Aug 2019 08:15:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/4] fs: always build llseek.
Message-ID: <20190828151552.GA16855@infradead.org>
References: <cover.1566936688.git.msuchanek@suse.de>
 <80b1955b86fb81e4642881d498068b5a540ef029.1566936688.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80b1955b86fb81e4642881d498068b5a540ef029.1566936688.git.msuchanek@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 10:21:06PM +0200, Michal Suchanek wrote:
> 64bit !COMPAT does not build because the llseek syscall is in the tables.

Well, this will bloat thinkgs like 64-bit RISC-V for no good reason.
Please introduce a WANT_LSEEK like symbol that ppc64 can select instead.
