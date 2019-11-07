Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4EEC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BF92085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="Ai9WM98m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbfKGQpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:45:05 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:38556 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfKGQpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:45:04 -0500
Received: by mail-pg1-f178.google.com with SMTP id 15so2431303pgh.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 08:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9fDi5idh+0YnvsfvGNTaSXXIz2wOd4ohinrW8IQawHE=;
        b=Ai9WM98mSwL01Q2QhsAJu8HDLzq4+33bhwhJvmfjcVBsES0tv5mMMQsexCSS1snU1Y
         3TPWT6H+KtvrvxVf7DBc+lx3ruOQYCX4U7ul/wsua8x7/WQuhMRoCTXWQ2BXcaOcFSEb
         xacYaHsrvSb4zgfgGd/32QGI9REG1u1H66l4LNgHqQ/+96BFsIyxNGTSqokYTxYSKG2V
         1K5n95/9akHkpIHkldMY/2cwouaK2NTz/0jbvEbKC5WvGFjJcP9jxvk+vZLCMPsNaAyo
         84Q7NpGMTQHaY5WeIdVcGgSBsti1Vk5WxpJc0IsbWdZaIsE2CPRR2frS5M5QJdrqw3YG
         BtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9fDi5idh+0YnvsfvGNTaSXXIz2wOd4ohinrW8IQawHE=;
        b=dRRAl0NIbT8G+UfKQbWdLnYDxrjhs7HJquFZfZxU+PInNS/NnfQK6ZrXC/eqeL/Vhk
         mGEbJsFR9lCDV9aLVbOt690R1izoIBXdMzxutqLDOhMBfrnl3SxfweItbXUy3/QduFnt
         2FkRymaf8Bti3FUOLi+pojAVP1I6exsFl55vTraDKN02+nIy8/xD4BD0s5cYT2AivC4G
         +WnqjH6/u1HLbrmDYdoFb1BGTJIGr2yaX+h2X4gIZ7OQ6F5WabzvMPPRNjMG20OcVdik
         SSY6ae+2FjzDZI086F2SYuPhCj3+aa5yMCSFYkWCjokvBbmuElTwJb2DAlH577Z4vrPp
         aY1g==
X-Gm-Message-State: APjAAAVNiF0T/2MEJF6odUxgfrL24cWiJVnrEDntRQ8xbVTy/yjH7K1C
        G7jzcTq65ZrfgFhiUWA2PXm9BA==
X-Google-Smtp-Source: APXvYqy2+RDZHukJZxBehyElTALNAHz6//WJVn3zuSzoUUNMpH9DtJr54A5LaAn+v2HcnkYBI2KfEQ==
X-Received: by 2002:aa7:8610:: with SMTP id p16mr5205592pfn.185.1573145103593;
        Thu, 07 Nov 2019 08:45:03 -0800 (PST)
Received: from shemminger-XPS-13-9360 ([167.220.105.73])
        by smtp.gmail.com with ESMTPSA id s11sm2386550pjp.26.2019.11.07.08.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 08:45:03 -0800 (PST)
Date:   Thu, 7 Nov 2019 08:44:55 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Willy Tarreau <w@1wt.eu>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 8/9] x86/iopl: Remove legacy IOPL option
Message-ID: <20191107084455.00f24f49@shemminger-XPS-13-9360>
In-Reply-To: <c6269309-0035-002c-8fee-72b37d42bb33@suse.com>
References: <20191106193459.581614484@linutronix.de>
        <20191106202806.518518372@linutronix.de>
        <c6269309-0035-002c-8fee-72b37d42bb33@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019 07:11:49 +0100
J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wrote:

> On 06.11.19 20:35, Thomas Gleixner wrote:
> > The IOPL emulation via the I/O bitmap is sufficient. Remove the legacy
> > cruft dealing with the (e)flags based IOPL mechanism.
> >=20
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de> =20
>=20
> Reviewed-by: Juergen Gross <jgross@suse.com> (Paravirt and Xen parts)

I am happy to see this go. The DPDK only did initially because it
was only way virtio would work at the time.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
