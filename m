Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4255C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9526206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="SZCmKJP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLCJzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:55:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35674 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfLCJzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:55:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id j6so3069010lja.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 01:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Hv+Pds3vFXC3zGf7lcsSE/HZtqLjppCdeoWk5E8JtRk=;
        b=SZCmKJP6H4Orpk4pbjEoc8btCiRad6RxEpjVhsOAj+Ui27spoh+5SX7bPhzFtFm0Zu
         javlHUKAVkch6ScVcRxBdqC7VvR3gNQKXtKOF4nUnoqeUX1v9toaER2EVDchWVCDZ+87
         nsL8wD6+LjyrgeSEi4QtJlYvKIkdtqkBEFBttWO8a9bZ8H0DCnDkrbDzz+gr68SnLGwT
         6tT5ryOmVi8P7jWRGc8+poPLuQOWtX74Fm7jLctwlPoy4JUnEDhDObCC82jYLcQYH4bL
         r60N83z6VT8GScFOFpQTzKjmuN+qJSB9LzJ/N2l0OSKS9JAgKWiW9dDvFzE4C46WDoF9
         sDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Hv+Pds3vFXC3zGf7lcsSE/HZtqLjppCdeoWk5E8JtRk=;
        b=uVhuBuxw2wd+7s9V1zr3uS+bIxxV6P+O4GX4KLjB+1PP0FYkCCfrVitWxHKXUgo1ag
         thQMTXfBGq4M2IlpX3zeyaAVOdlFbqHcC/xnXwkSrGeFHOZu6pmQiP1E8YOUXgC+qQeC
         0szKcLFIROL3bqPRNKEIKcuHg3gfjvKvKhlZVoMy0EvxsoP+RbyY9SD7JLVfqKMS3j9I
         8JTTtzYj5sugxPnoQOU7kkNPfwYVCxDFgbko/9VLe5F7vZbtyL45jfjsjTx8ubIcwIpS
         VXkDCYVYJcqeSb369QwsDdWy79072M2G54UFLp/sleupGPy+888kKhgLBk55G2Vf7m5U
         DATg==
X-Gm-Message-State: APjAAAUok53VZu8TDOlu3M8ET1a+NljexSU9qnrHCnvmFEAJDuwn7MKO
        khXuEUvjOCFlxFCahdf7/tIVrw==
X-Google-Smtp-Source: APXvYqxHj0JhbG9jjzg41QnjlnwGNECa6RkKnj/0qML2HC15ujiF8SjbpJzUDbrr+t4eOGwDt2QOYA==
X-Received: by 2002:a05:651c:1067:: with SMTP id y7mr1888203ljm.123.1575366904017;
        Tue, 03 Dec 2019 01:55:04 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y192sm1134240lfa.63.2019.12.03.01.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 01:55:03 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 55EAA100494; Tue,  3 Dec 2019 12:55:02 +0300 (+03)
Date:   Tue, 3 Dec 2019 12:55:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@vmware.com, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 2/2] drm/ttm: Fix vm page protection handling
Message-ID: <20191203095502.hw3r33ioax2x4kvt@box>
References: <20191203075446.60197-1-thomas_os@shipmail.org>
 <20191203075446.60197-3-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191203075446.60197-3-thomas_os@shipmail.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 08:54:46AM +0100, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> We were using an ugly hack to set the page protection correctly.
> Fix that and instead use vmf_insert_mixed_prot() and / or
> vmf_insert_pfn_prot().
> Also get the default page protection from
> struct vm_area_struct::vm_page_prot rather than using vm_get_page_prot().
> This way we catch modifications done by the vm system for drivers that
> want write-notification.

Hm. Why doesn't your VMA have the right prot flags in the first place? Why
do you need to override them? More context, please.

-- 
 Kirill A. Shutemov
