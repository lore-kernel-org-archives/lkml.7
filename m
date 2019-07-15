Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF782C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836422086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="YDX5Cni6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391575AbfGOOxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:53:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35284 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391543AbfGOO3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:29:19 -0400
Received: by mail-ot1-f66.google.com with SMTP id j19so17201952otq.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 07:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6QkSbJ8pehcPJsEqSW/0Jw3Kj7WtEh8gEc9PVJH1CrA=;
        b=YDX5Cni69En7Hnte+J3OlCSJ0HlBPkTtUerLm+TEt90UKpDUfDuJvjCxyA/xsbdN+4
         NlM28WRfcpu6byVaPN4oE7VH4s3k0vd1hEb+a57aabIHxBzldliL2Htoq2btKjK4n7AS
         dEk3INMwrusBqXJOHjVd5y+1ZYzs3lAeIPfrwgpru+b49OUDLgXf6+CpcsZ6fG8itG0F
         1l0rPwOFa7qBIOGncKcrTTI0b32v3jNfOV6b+s6CSQAQGdFNyL4RrykbWCb0WlSmG84g
         rPg2y0ELpTG/hNU8ek2ztwI6ffWkYO0HuhjiHpT2javBLichO07Q+0RuqzlaxnSebk5a
         7e7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6QkSbJ8pehcPJsEqSW/0Jw3Kj7WtEh8gEc9PVJH1CrA=;
        b=WxEbnyG9Zm0vVyWAsbEeia1sGY30bi2iS3qMr/53VdiMte7ou95Q8g8YbcgPVAMnUd
         7j6KdrKeDp38/816Rqcd4+fPKoad8OvvTvrugRd+to5Ohe/YR/4UHTQu2u4HvuzP668Q
         uwBp/kvDRXv+ap1Km31qoPJsgG79TjWfWGWSqHE9RL/a4fPUYEPy1mBvair/kRuRM4aa
         iDl5mjfLLD321uO+JY9WNhZ2ZSZJQSK9esfOUvFTbIpu0oVTxgnMV+11DmWuhDZJhHv9
         4tLkQAoKLyyMWRIDyauN73ij0IkrbJrzSmAVV8wdTsxAT7yRHsB53frVXltM1zvOfmMO
         oixA==
X-Gm-Message-State: APjAAAVXTpI3d8+LmhdlDtY5KizEqUAxN3xZvW5RYdytC6xy0FrCeyJ3
        /r2o9eeztba/fZDhHsFyWrU=
X-Google-Smtp-Source: APXvYqyjL0Ot/+YneSRjZE4d+NlwotmvVCLCkSyihKbIEGxxfUrBUzxa4ggVFEdDWrNvLtFCu+w3cQ==
X-Received: by 2002:a05:6830:193:: with SMTP id q19mr20811013ota.187.1563200957973;
        Mon, 15 Jul 2019 07:29:17 -0700 (PDT)
Received: from brauner.io ([208.54.86.135])
        by smtp.gmail.com with ESMTPSA id a94sm6577090otb.15.2019.07.15.07.29.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 07:29:16 -0700 (PDT)
Date:   Mon, 15 Jul 2019 16:29:09 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/2] arch: mark syscall number 435 reserved for clone3
Message-ID: <20190715142907.7p43dgmx5sz5oouz@brauner.io>
References: <20190714192205.27190-1-christian@brauner.io>
 <20190714192205.27190-2-christian@brauner.io>
 <e14eb2f9-43cb-0b9d-dec4-b7e7dcd62091@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e14eb2f9-43cb-0b9d-dec4-b7e7dcd62091@de.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 03:56:04PM +0200, Christian Borntraeger wrote:
> I think Vasily already has a clone3 patch for s390x with 435. 

Excellent. I'll leave the # 435 reserved for clone3 on s390x in until
this patch has landed. It shouldn't be a merge conflict and if so it
should be trivial.

Christian
