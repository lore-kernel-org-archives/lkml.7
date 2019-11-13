Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AF7C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E205920818
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573607045;
	bh=JJryAeN8i7HuiftvjnPY5CfaGvShDEjNwJ4TV0qufdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QrKhNe+Q0CBjcGjQ3cVwlydhSvsaxlC5UBV04C+t9hXy449LKsF6K8UDC8CTDE5Ae
	 uWtqyjCWhnhi3fS/dEz96J4RpLmGoa7ywi4CHLbuAcFdRfl3VcmiYUfnvcv85lTN6w
	 gik5Fay2HmhfXCmTlZ2AK/kMGHvr9cir1nEvUb/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfKMBEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:04:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33429 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfKMBED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:04:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id h27so206263pgn.0;
        Tue, 12 Nov 2019 17:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AuVeBzwJ3ZZqr/vAOHVER0+LDNiK4YMwoTRZY1dDoeg=;
        b=E4GgGj1LpatYxzgiehqjQYjQEhF1Gi7gX1pJqF4IbmTufvTO0EpxigD+xFFDs1fJ4f
         wl/CPUR37dBzii65rycD2xDBKTKYzzrEqQxPhYZ01NNthghFMTRd5UtHDj5k1WvM/WOw
         M1wnpzGm9us4k7GU7wrzYpEjBUsYFeJ6THf+jWs2DWaQ+WUmEgjacyOJYCR4lR59OEEN
         hQl7hc3BCbP/UbuFjK6V6pL0F3QuMVhWygHVqibca0uBDAZiSMeCRDlRrYb/l2g5yRFV
         /Jhpo5pNi1cU9+apxdAFlQ+SgpP16q8BPZqQaScKrvwXIlFwa1Odp6UfJBtabtgOZ3Fu
         Q/9Q==
X-Gm-Message-State: APjAAAWoFdfAPiz7EE4hlbeo45vQC/e13NNv8H+xgul+e4QMNO2Xwi2v
        /P8pi414ORRVoJjn4vQM/yc=
X-Google-Smtp-Source: APXvYqwYvOM4Q+SitB6KhGvZTSLCXdClAWAbbYWGC5oVp9dRV5SVknvoJoPCrCqBdtjTjqL3PGrfaA==
X-Received: by 2002:a17:90a:cf08:: with SMTP id h8mr966661pju.77.1573607042784;
        Tue, 12 Nov 2019 17:04:02 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v26sm189565pfm.126.2019.11.12.17.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 17:04:01 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id DDE1F403DC; Wed, 13 Nov 2019 01:04:00 +0000 (UTC)
Date:   Wed, 13 Nov 2019 01:04:00 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
Message-ID: <20191113010400.GV11244@42.do-not-panic.com>
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
 <87d0e8g5f4.fsf@x220.int.ebiederm.org>
 <f272bdd3-526d-6737-c906-143d5e5fc478@gmail.com>
 <87h83jejei.fsf@x220.int.ebiederm.org>
 <eb2da7e4-23ff-597a-08e1-e0555d490f6f@gmail.com>
 <87tv7jciq3.fsf@x220.int.ebiederm.org>
 <1b0f94ef-ab1c-cb79-dd52-954cf0438af1@gmail.com>
 <201911121517.DC317D5D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911121517.DC317D5D@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 03:19:00PM -0800, Kees Cook wrote:
> On Tue, Nov 05, 2019 at 09:35:46AM +0200, Topi Miettinen wrote:
> Is a v2 of this patch needed? It wasn't clear to me if the inode modes
> were incorrectly cached...?

I provided a review for it just now. The patch is cleaner but I believe
it can be split up, and also I am not yet sure it is correct. You were
CC'd on it but the subject was not clear that it was a V2.

Topi, if you send a V3 can you please prefix the subject with this?

  Luis
