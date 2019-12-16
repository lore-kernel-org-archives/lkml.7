Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ACBC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44292067C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QsIADyvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbfLPQFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:05:31 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42081 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfLPQFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:05:30 -0500
Received: by mail-qk1-f196.google.com with SMTP id z14so5608283qkg.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 08:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+lKQBDpzDPcg15QBEHobBzdq4ppx02T+T0NScAe4/rA=;
        b=QsIADyvzRl9qoNxQVFr7adBzvQjOsTJR7jI2oGaHKBK2GYda2oFKhnUM4xsOl/UMeZ
         bv3vJ75KMRCZfpDFk0zrSDBcVzpxUeN9Re6zIr5fB/AhTVSxcq5SWQyxUXf1VhA3JQ38
         OtXjHCD7meb2uorDQ4B8xW1i0pURq1ZiCyEKVoudzSWAC7/ETU95NvFX161h2xTesLtu
         4CKCXS25EHzRA2iiyARcykUTfWjbc8j7uq0YAG6OfWm3eSPsxturRhZ1hQmkFlcMsE+k
         THvZZRA5PRenWMpOZSycSBezhCZaOOfS/SpDxP7Y8oey3DrqEVkfsXSpow6ryeiYCngM
         HWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+lKQBDpzDPcg15QBEHobBzdq4ppx02T+T0NScAe4/rA=;
        b=nNn+BM9qe5uQfyfrGQ+2jUSiuZtYqCxWqCh2hqIewpqFw4I9DpjkysroozoGbEWJ/c
         mknGrStu8fauJaxl7h5nX8EjMcY5AX9VnDWSUTUY4v2bWX3GGibHsBXj9IXEGlpluln7
         nBewUFgrt4kUdGA/kV9iygOfNlIlmvY2IHJ5Cno2fGZBMLhQbc5xEGb3+iLZVnyRE9Ye
         BWWX8nHB+kQ/kOVvwgu5fJQAc6JroLhdbRLcIpgNF8Af2gVHMmYIj4NYQG/J8TTu6eWc
         57lcXRyMUymWeZBtrWMmzMfsY72957W4hk05+W/0n552wQAWLaIQaZzmZ6S7ffQNqk7J
         Hj1g==
X-Gm-Message-State: APjAAAUAyvpO757YVxJrQ2mWcOB+7n2sX04qe9krWEo0SjQ560l+btPQ
        DlGVcsrbUxsFgVM3y2NdWKIWjwt8dUlFiA==
X-Google-Smtp-Source: APXvYqwzTOp0qWhlavl8UpEOrZOd6WkqWpFywuJjzXs13a42ZVBjXmBZSsWQfNbKB9CjvluM06GlvQ==
X-Received: by 2002:a37:6d5:: with SMTP id 204mr25587692qkg.448.1576512328086;
        Mon, 16 Dec 2019 08:05:28 -0800 (PST)
Received: from ?IPv6:2620:0:1004:a:6e2b:60f7:b51b:3b04? ([2620:0:1004:a:6e2b:60f7:b51b:3b04])
        by smtp.gmail.com with ESMTPSA id r37sm6992733qtj.44.2019.12.16.08.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 08:05:27 -0800 (PST)
Subject: Re: [PATCH v5 2/2] kvm: Use huge pages for DAX-backed files
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Liran Alon <liran.alon@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jason.zeng@intel.com
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-3-brho@google.com>
 <06108004-1720-41EB-BCAB-BFA8FEBF4772@oracle.com>
 <ED482280-CB47-4AB6-9E7E-EEE7848E0F8B@oracle.com>
 <f8e948ff-6a2a-a6d6-9d8e-92b93003354a@google.com>
 <65FB6CC1-3AD2-4D6F-9481-500BD7037203@oracle.com>
 <20191213171950.GA31552@linux.intel.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <e012696f-f13e-5af1-2b14-084607d69bfa@google.com>
Date:   Mon, 16 Dec 2019 11:05:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191213171950.GA31552@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/19 12:19 PM, Sean Christopherson wrote:
> Teaching thp_adjust() how to handle 1GB wouldn't be a bad thing.  It's
> unlikely THP itself will support 1GB pages any time soon, but having the
> logic there wouldn't hurt anything.
> 

Cool.  This was my main concern - I didn't want to break THP.

I'll rework the series based on all of your comments.

Thanks,

Barret


