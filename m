Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB90C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D08D21A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389584AbfIZFBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 01:01:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbfIZFBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 01:01:10 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AEE0C057F88
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 05:01:10 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id h189so657332pgc.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 22:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xQhoAUabi0ck+laQwaWiJC+2AXNGicrQtCWuvtB/rXI=;
        b=hZG6F0aFCTa+DZT514GMCTNTBdekCuFrsUTcEt6yJNc6CW9WjSPgpDWOmeMoE0Go9P
         IC5Sola5Qw4zYQSQ3d1aOf93TLChy3IqP/exC06S27slWBGXPxJwn3s7kn8IMfDsc7ho
         Hxh3IUnCLCgs00GOQrPGyuTyyb0XE7CBe9hQ0QteUJg8cyKE/anNofBB3ur+W/MO66/W
         JmKdpqvgtQ3VfMdraciS4uDRGqzNaBbu1h4L+h/aUdt/6yFJWoyL4w/Mh51gubHZJV/J
         4ojNqJu9XaG8rtDlhrnJ5YCaATSG42Z5bCzhguENsAGYvNt9MtO8x6RDoL7TuYEU+D5P
         XIxg==
X-Gm-Message-State: APjAAAWxgnTSEoSGJlO+i+a6M57ZyKu0nm1OFkLLwLkwhw9ihM6N5beQ
        AI9qxC9o4+o2f+1ji7XquTaL0LtPEurIQxkVnU0OizWSyagzav9RV+xCPNlaAKNBV/HxHUi/TK5
        sa/4yyjnVlaP54+Fr1cqOD+fm
X-Received: by 2002:a17:902:8f92:: with SMTP id z18mr1885999plo.248.1569474069946;
        Wed, 25 Sep 2019 22:01:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxcUCXn5jzjUbzHlAKrE41fUCLr0dAwYxICUC4oMrTySJKWJt761OhGJ0Xgymix9SgF3IyGVA==
X-Received: by 2002:a17:902:8f92:: with SMTP id z18mr1885962plo.248.1569474069536;
        Wed, 25 Sep 2019 22:01:09 -0700 (PDT)
Received: from [10.76.0.124] ([125.16.200.50])
        by smtp.gmail.com with ESMTPSA id 6sm836051pfa.162.2019.09.25.22.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 22:01:08 -0700 (PDT)
Reply-To: mgandhi@redhat.com
Subject: Re: [PATCH] scsi: core: Log SCSI command age with errors
To:     Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        Laurence Oberman <loberman@redhat.com>
References: <20190923060122.GA9603@machine1>
 <c28778e6-62a1-b510-f6aa-fd67b54ca54c@acm.org>
From:   "Milan P. Gandhi" <mgandhi@redhat.com>
Organization: Red Hat
Message-ID: <01be9696-b7ce-4601-0a0b-a7cbb234b1ce@redhat.com>
Date:   Thu, 26 Sep 2019 10:31:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c28778e6-62a1-b510-f6aa-fd67b54ca54c@acm.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/19 9:15 PM, Bart Van Assche wrote:
> On 9/22/19 11:01 PM, Milan P. Gandhi wrote:
>> +    off += scnprintf(logbuf + off, logbuf_len - off,
>> +             "cmd-age=%lus", cmd_age);
> 
> Have you considered to change cmd-age into cmd_age? I'm afraid otherwise someone might interpret the hyphen as a subtraction sign...

Thanks for your suggestion Bart.
Yes, it would be better to use cmd_age to avoid any confusion.
I will change it and send the updated patch.

Thanks,
Milan.
