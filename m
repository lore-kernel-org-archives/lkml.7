Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341F0C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 22:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9D22183F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 22:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uTXTnKqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfEKWsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 18:48:23 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41485 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfEKWsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 18:48:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id y22so7352607qtn.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 15:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GSl4RsrGfhdUH+i0bbuYN1DLTdrtQZzyM4JzXC/cG0Q=;
        b=uTXTnKqIPoylmFYEdNTvQbpOCQR/TKRL184xP6NRVz2vgk8g2p37WXOhQaeOmDbcfD
         HolWXcAw3Yi8UzTsKeuzxDCu15vlBkGc0ByX9J8RGwplBy1XmlEI0zEn570qqyhuHnip
         vH8xmIqtNkiLpUwmIxMZmUeLvqRq8y512YIsEoRJHtsptGeIJw4g/Mdc20ImK4fjgskw
         ZNJcez9SaQvNYYtRaC76wGr2JTqmXTHiBoChHXoNFHzT9lCLv33W48prW4iiqRQlWi/z
         40h0kbzHnrpoakxZxXDZbexWH3fU4iHJTq6r1z8wyt0XxEGPTpI/g9v/U6bRANHVUc7e
         eCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GSl4RsrGfhdUH+i0bbuYN1DLTdrtQZzyM4JzXC/cG0Q=;
        b=X6d2FnEODg+Nrdx3YYc7JQz2mwifHdjuPIlh3dL3ypfh3IVLyXvsSISmG31qmfne7p
         pWmyONOjb54fPjDF5I4TFflQGwFH1gyVMEuatZphCxDnl7yTvt4hy/F6/cLpt/q3mt7z
         c1lSpTEXasUvOfqQB/fJKq8dXsIOJGMgKCcN4PTCNnzXNnUbOMnR4q2TZ/nEOnUDc+OF
         r4pa7+ZBfAQtEdxVJgO0iLG86uDUUObzZXre8O+K5R+qo5gPS4A9yJsUJvvA1UcLo+Wo
         6DQSEp2OODefFrT9vkz/CQQZnf+zmZnjlMbxR/Wz59OZ7UQzLfdw9EcQ5bhrpnciBuVh
         kxmQ==
X-Gm-Message-State: APjAAAVtW4yvBL4xTlbNfNxz5Wf+N4M410kaqFXcgbhUUBFX4ZG3QSb6
        GF/QWdh+pUfUQRhdGvDUvCoHCkF6
X-Google-Smtp-Source: APXvYqyuLR5UKsU7WmmMe1U5lS5XWAmrs80dqE5dV/N4ASCb6+D3t774ZJK9RhLg6BYNp3be5/y8vA==
X-Received: by 2002:aed:3108:: with SMTP id 8mr16472515qtg.314.1557614902352;
        Sat, 11 May 2019 15:48:22 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s55sm5294609qte.17.2019.05.11.15.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 15:48:21 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 11 May 2019 18:48:20 -0400
To:     Arvind Sankar <niveditas98@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: kexec failure (Undefined symbol: __stack_chk_fail)
Message-ID: <20190511224819.GA71308@rani.riverdale.lan>
References: <20190511191658.GA25716@rani.riverdale.lan>
 <20190511194048.GA57048@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190511194048.GA57048@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 03:40:49PM -0400, Arvind Sankar wrote:
> On Sat, May 11, 2019 at 03:16:59PM -0400, Arvind Sankar wrote:
> > I'm running v5.1.0 trying to kexec into v5.1.1. I get an error when
> > trying to load the kernel image, I enabled some debugging of
> > arch/x86/kernel/machine_kexec_64.c and got the following log:
> > [90028.591812] kexec: Applying relocate section .rela.text to 1
> > [90028.592438] kexec: Symbol: sha256_update info: 12 shndx: 01 value=159 size: 1bc4
> > [90028.593077] kexec: Symbol: purgatory_sha_regions info: 11 shndx: 08 value=0 size: 100
> > [90028.593744] kexec: Symbol: sha256_init info: 12 shndx: 01 value=117 size: 42
> > [90028.594406] kexec: Symbol: purgatory_sha_regions info: 11 shndx: 08 value=0 size: 100
> > [90028.595086] kexec: Symbol: sha256_final info: 12 shndx: 01 value=1d1d size: b5
> > [90028.595775] kexec: Symbol: purgatory_sha256_digest info: 11 shndx: 08 value=100 size: 20
> > [90028.596486] kexec: Symbol: memcmp info: 12 shndx: 01 value=1e9b size: c
> > [90028.597203] kexec: Symbol: purgatory_backup_dest info: 11 shndx: 08 value=130 size: 8
> > [90028.597947] kexec: Symbol: purgatory_backup_src info: 11 shndx: 08 value=128 size: 8
> > [90028.598701] kexec: Symbol: purgatory_backup_sz info: 11 shndx: 08 value=120 size: 8
> > [90028.599449] kexec: Symbol: __stack_chk_fail info: 10 shndx: 00 value=0 size: 0
> > [90028.600199] kexec: Undefined symbol: __stack_chk_fail
> > [90028.600955] kexec-bzImage64: Loading purgatory failed
> > 
> > I have attached the config.gz from the running 5.1.0 kernel and the
> > built 5.1.1 kernel. The config was working ok with the 5.0 series.
> > 
> > Thanks
> 
> 
> I get the same error message when trying to load even the currently
> running kernel.

Hm this has mysteriously disappeared after cold-booting into 5.1.1.
