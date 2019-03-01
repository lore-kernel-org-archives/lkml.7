Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955E7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5989020818
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6r9OupR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389283AbfCAQyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:54:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45502 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388993AbfCAQyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:54:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so11681513pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 08:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=v8H6VN36oH6WU7j+Z98Gq/uFnx5u2KaHkgPBc2ET138=;
        b=I6r9OupRZemMH0yWoIO6KKAxYf1g2M9H6rIYxzDE493TA0OORw7nelbafwVUPhXM4m
         fVD4MwEgb4GOuPkKJ4WVetfD0KEQSqKOh7DB81MrH4hKom+rWxKVYI6L0iqNL+Z0tVUI
         pmf+vk8V5qFpHYhxrpXASF4weaVEsISeF0AY/NY3JLNk/DyCCFB5UcXj+gFIwEvmpp9z
         qE4f9M9vdeMyH6mh0xTm1kuJvzvufpznNYV5WUhx2rEB6ZvvAocTbTX1TT1N9moogyxW
         IUFZSDXwkGHjT26040ToE7KEzOhTD3xqUSPTyqBNEyuPUHbkRCpz+dUzSeHHAOf3yjCh
         3D3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=v8H6VN36oH6WU7j+Z98Gq/uFnx5u2KaHkgPBc2ET138=;
        b=jHq18T1yigBoOleQdN6/gbuCzKKdx3SJSdM2GVHGRboUSh9Dffi02GwUK32MvwgBst
         iQnPc5PuPDH9I9bmfQT6GK/mLzEXyspwrFb2oZX7xEtlcWAj+XEIuxlWBaBxOH+DgYUV
         Jmao7DBVetzmMDwo9TP8mlXLGQbuzG65jZpJuoHYxXhQv4SFyPhINEy/h2YCuhOgkLgk
         wyJmAyJQc4eZrKt0T9Nur8QJWfK/zcDJUjmz9dYnkwU+/piGaZQEdaOyLfli8BltIUaT
         X77B7ciB8l3Au3avIABnMTOJmf5rm2sNaWgINxWhldVIZYqp2FRfqaAlEPaaBHkAeesR
         TTHA==
X-Gm-Message-State: APjAAAVaougnhawbMBq/bXptbkMETXAcZUmmayZ5JOVubjGhvhInq77h
        nTGXdb2K9DfcZnQWzIR4Lyc=
X-Google-Smtp-Source: APXvYqyCVrv6u79M3KrfhXHDimG5Wc3rxFXSj1v+2cybauUCmNrKyP1NPu86Bxe/Xx9wHvkCtzn6lA==
X-Received: by 2002:a63:cc03:: with SMTP id x3mr5678881pgf.121.1551459282838;
        Fri, 01 Mar 2019 08:54:42 -0800 (PST)
Received: from ikegamiPC (M106072039032.v4.enabler.ne.jp. [106.72.39.32])
        by smtp.gmail.com with ESMTPSA id m13sm47711334pff.175.2019.03.01.08.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 08:54:41 -0800 (PST)
From:   "Tokunori Ikegami" <ikegami.t@gmail.com>
To:     "'Boris Brezillon'" <boris.brezillon@collabora.com>
Cc:     "'Tokunori Ikegami'" <ikegami.t@gmail.com>,
        <keescook@chromium.org>, <bbrezillon@kernel.org>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>, "'liujian \(CE\)'" <liujian56@huawei.com>,
        <vigneshr@ti.com>
References: <1551189648-58073-1-git-send-email-liujian56@huawei.com> <016001d4cf71$865e7b60$931b7220$@gmail.com> <4F88C5DDA1E80143B232E89585ACE27D0264F137@DGGEMM528-MBX.china.huawei.com> <20190228164228.734ede80@collabora.com> <005a01d4d03e$39b0e0f0$ad12a2d0$@yahoo.co.jp> <20190301170715.68d89e84@collabora.com>
In-Reply-To: <20190301170715.68d89e84@collabora.com>
Subject: RE: [PATCH v3] cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer
Date:   Sat, 2 Mar 2019 01:54:16 +0900
Message-ID: <000301d4d04f$76c2aad0$64480070$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Content-Language: ja
Thread-Index: AQHOptjmAmqem5WpXlLpfOi8uScBsQIgzkq5Atg5CjYCPRAs9gF4c9/ZAQMTnbultcD/MA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris-san,

> -----Original Message-----
> From: linux-mtd [mailto:linux-mtd-bounces@lists.infradead.org] On Behalf
> Of Boris Brezillon
> Sent: Saturday, March 2, 2019 1:07 AM
> To: Tokunori Ikegami
> Cc: 'Tokunori Ikegami'; keescook@chromium.org; bbrezillon@kernel.org;
> ikegami@allied-telesis.co.jp; richard@nod.at;
> linux-kernel@vger.kernel.org; marek.vasut@gmail.com;
> linux-mtd@lists.infradead.org; computersforpeace@gmail.com;
> dwmw2@infradead.org; 'liujian (CE)'; vigneshr@ti.com
> Subject: Re: [PATCH v3] cfi: fix deadloop in cfi_cmdset_0002.c
> do_write_buffer
> 
> Hi Ikegami,
> 
> On Fri, 1 Mar 2019 23:51:16 +0900
> "Tokunori Ikegami" <ikegami_to@yahoo.co.jp> wrote:
> 
> > > Except this version no longer does what Vignesh suggested. See how you
> > > no longer test if chip_good() is true if time_after() returns true.
> So,
> > > imagine the thread entering this function is preempted just after the
> > > first chip_good() test, and resumed a few ms later. time_after() will
> > > return true, but chip_good() might also return true, and you ignore
> it.
> >
> > I think that the following 3 versions will be worked for time_after()
> as a same result and follow the Vignesh-san suggestion.
> 
> Let me show you how they are different:
> 
> >
> > 1. Original Vignesh-san suggestion
> >
> > 	if (chip_good(map, adr, datum)) {
> > 		xip_enable(map, chip, adr);
> > 		goto op_done;
> > 	}
> 
> --> thread preempted here
> ==> chip_good() test becomes valid here
> --> thread resumed here, but timeout has expired
> 
> >
> > 	if (time_after(jiffies, timeo)) {
> 
> you enter this branch
> 
> > 		/* Test chip_good() if TRUE incorrectly again so write
> failure by time_after() can be avoided. */
> > 		if (chip_good(map, adr, datum)) {
> 
> chip_good() returns true
> 
> > 			xip_enable(map, chip, adr);
> > 			goto op_done;
> > 		}
> > 		break;
> > 	}
> >
> > 2. Liujian-san v3 patch
> >
> > 	/* Test chip_good() if FALSE correctly so write failure by
> time_after() can be avoided. */
> 
> --> thread preempted here
> ==> chip_good() test becomes valid here
> --> thread resumed here, but timeout has expired
> 
> > 	if (time_after(jiffies, timeo) && !chip_good(map, adr))
> 
> You do not enter this branch because the chip_good() test is done once
> more in case of timeout.
> 
> > 		break;
> >
> > 	if (chip_good(map, adr, datum)) {
> > 		xip_enable(map, chip, adr);
> > 		goto op_done;
> > 	}
> >
> > 3. My idea
> >
> > 	/* Save current jiffies value before chip_good() to avoid write
> failure by time_after() without testing chip_good() again. */
> > 	unsigned long now = jiffies;
> >
> > 	if (chip_good(map, adr, datum)) {
> > 		xip_enable(map, chip, adr);
> > 		goto op_done;
> > 	}
> >
> 
> --> thread preempted here
> ==> chip_good() test becomes valid here
> --> thread resumed here, but timeout has expired
> 
> > 	if (time_after(now, timeo))
> 
> You do enter this branch, and erroneously report a failure.

I do not think that it is not entered here since the value timeo is compare
with the saved value now before the chip_bood() by time_after().

> 
> > 		break;
> >
> 
> See now why your version is not correct?
> 
> Regards,
> 
> Boris
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

