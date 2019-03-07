Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF1FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DF920675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0TV9H7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfCGSNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:13:01 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:36946 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfCGSNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:13:00 -0500
Received: by mail-wm1-f52.google.com with SMTP id x10so10133411wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x0bRJ6egfPsspCgoN/1H3HOQ6tPlJYzruFIgZD5Z3UU=;
        b=A0TV9H7/YK7+FKEaeWOHmBb0ljoEy5KkDpU6xAZM0fYE+ovg7p+5yyhTu8SXOj9LCP
         1RBhBmbWUA/oMsmZtUmi5tNsr77W/i2uijPYRhLi/QRVLhC7NI/W6vgvgvYT0FL5II7o
         mXiHx+UucN7418Ye10M5ukw7gOKjqoN7+QbjNGGvClcNQoBcFojoNcP4URJLaIhvBJVr
         gM/izONWdDNBhVW2G4YzmfqJeHe1XdTC2deqjcNWVlO33OQaPcNvcswyN4VuiNIik4bN
         Kop0wkgF3x4WoZsQ1Miu1cIVRcw038FTBMq1a2RwXNKD269aAtmWCBZ1xUmm65hqeu/j
         Scsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x0bRJ6egfPsspCgoN/1H3HOQ6tPlJYzruFIgZD5Z3UU=;
        b=fmzb9IfHriveG4ZPbLhGZk73Vvk4uY2NAf2sEX0GS30h0aF7tWsNlfkISKjrWpalaw
         UJ8dq8WtFnZLznfBR7qTPneLuAVn+xFoJuhyiVLRHwAVHwQ8w8KmEiT6tnbhsdZ1NUS/
         ZWQK25g5B6Y96BT6nNEOu+ZZLJc0GNATzryPPB9jVVIQ6mwNbWEDQTuSUmr1zDpqaRkw
         8nkfYa7wg6cJ6ADCjJryta48pc3nAj65MTgJyCwJKBBLKaG0Mm/Ua7y56gLwVr/y035r
         97fw+qP3wyWgB9Eo2KKQx9VT0bhojeWXz6M2rtd85Hhk77Neb+pLgwnyKY9UPJFj0iDT
         pnjQ==
X-Gm-Message-State: APjAAAVMN/6R6FcVD54QezhIx4N5aps4NUeVLLH2FSigXU7rmvdL+Eji
        GvX44BxdPtbVOQp9StSsAInOVb8=
X-Google-Smtp-Source: APXvYqwW01MNLrutpvpsRabKiPYhrMSKFD2qOZknjfXvNnoOtsgy1KBn1duwg7ymzhs87kzDXcpyZA==
X-Received: by 2002:a1c:a9d0:: with SMTP id s199mr6471648wme.142.1551982379054;
        Thu, 07 Mar 2019 10:12:59 -0800 (PST)
Received: from avx2 ([46.53.242.20])
        by smtp.gmail.com with ESMTPSA id o12sm9063017wrx.53.2019.03.07.10.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 10:12:58 -0800 (PST)
Date:   Thu, 7 Mar 2019 21:12:56 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lkp@01.org
Subject: Re: [LKP] [proc]  3f02daf340: kernel_selftests.proc.proc-pid-vm.fail
Message-ID: <20190307181256.GA10410@avx2>
References: <20190203165806.GA14568@avx2>
 <20190219094722.GB28258@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190219094722.GB28258@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> selftests: proc: proc-pid-vm
> ========================================
> proc-pid-vm: proc-pid-vm.c:277: main: Assertion `rv == strlen(buf0)' failed.
> Aborted

vsyscall mapping enabled, I'll post patch shortly.
