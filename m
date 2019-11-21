Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CD4C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B77B206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OdoPyR7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfKUWem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:34:42 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:42929 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfKUWel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 17:34:41 -0500
Received: by mail-io1-f51.google.com with SMTP id k13so5427037ioa.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 14:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IEXRl1a+YG5Fq04/5MkpCQWm0sRXqQh5qIxa1yzUOE8=;
        b=OdoPyR7j2dWD2EKhKoX+AqlSZqLJwnf+XwVKTz1UBVTQrRbTwgsFVmLA+Rr7RrUPQt
         ryPNmHqJDWfTGpgZcaKIiiO3AtSD5jWaYfPfbA2LrBkk+oOqoEaBt2tVaUbDaGphMKVC
         XcZiw/a3n9j4iND5gL8ObL8JkzUjYsKvRy+sxb6H/11Nh8m6U4KSLMw7cM6dJoyGJupD
         zBfZCDWelwAM9DmrxrM9MrXPphgmkt+1VgMWUDxsL677x0+sMDPRbiq6v1lALr3koV5I
         nkBX8rS96JkbJVmWPKdrSdKuVmJBBGdXafYGjJUuXNAEW7OBxsTJn4ed6/r4zVCh5stv
         oZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IEXRl1a+YG5Fq04/5MkpCQWm0sRXqQh5qIxa1yzUOE8=;
        b=iB6+eSQAt+ZiLLsDyfqSNQlgye0X1pvrqm0YXgJ71W4j8X/Ei7wily2Lb63/G+gTgh
         /pa3ZATW4SoILs5weQbcScTvyIbDX5V4l/25NayuWee96EasdRxjL5r72gdBqLzNtrKs
         1lU8WTmAx1mVF2rCMtehLfYcijdnBnNuYMv3jMdKT7nj+FFsCf8ztVbyFH8H/O1VXDDP
         nxAbFoHInE+N3Yx7AuplYYeFzMPFog9LATY22qMxa6Z5r829XDI4e2lT7WK0wWzrDAr9
         qCJctPcB10pFpMHNccp7AKxU/Z7yeTSMffSqfvhHx0i2msZYgsI0QI93Jd5ABCYlKKcD
         ebog==
X-Gm-Message-State: APjAAAVLLFsxO9w0RftjfgUi5AEsEc87QPWeo4rSnTIm9opyMTvwrnvI
        znER0xfsZiwrmytszhzHJo5NSye6XFg=
X-Google-Smtp-Source: APXvYqzs+NMHBlSAa+EaVfa9kefjlGaH9Rjrqw972sM7gZS1oBEBMQGrYQllXqlWnn/9vr0i0NPaUQ==
X-Received: by 2002:a6b:14ca:: with SMTP id 193mr9847476iou.140.1574375681046;
        Thu, 21 Nov 2019 14:34:41 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id k22sm1413904iot.34.2019.11.21.14.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 14:34:39 -0800 (PST)
Date:   Thu, 21 Nov 2019 14:34:37 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     =?ISO-8859-15?Q?Patrick_St=E4hlin?= <me@packi.ch>
cc:     linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC/RFT 1/2] RISC-V: Implement ptrace regs and stack API
In-Reply-To: <20181113195804.22825-2-me@packi.ch>
Message-ID: <alpine.DEB.2.21.9999.1911211433270.5296@viisi.sifive.com>
References: <20181113195804.22825-1-me@packi.ch> <20181113195804.22825-2-me@packi.ch>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2143778827-1574375677=:5296"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2143778827-1574375677=:5296
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 13 Nov 2018, Patrick St=C3=A4hlin wrote:

> Needed for kprobes support. Copied and adapted from arm64 code.
>=20
> Signed-off-by: Patrick St=C3=A4hlin <me@packi.ch>

Planning to queue an updated version of this for v5.5-rc.  More=20
discussion here:

https://lore.kernel.org/linux-riscv/alpine.DEB.2.21.9999.1911211418320.5296=
@viisi.sifive.com/T/#u


- Paul
--8323329-2143778827-1574375677=:5296--
