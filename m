Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E924C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6495320652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exXm1KbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388956AbfDRNdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:33:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36819 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRNdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:33:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so1133555pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 06:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8rHy5dxRGESiSX8AnpAwnoYq2f6DwiON33y2JxbSAsk=;
        b=exXm1KbHdICGWXOhNNzFDqWjPiExalVBQyx1sj9MfjqA0lnKhbEfnU1fiD6+1ydBYT
         5Nz7sNP5AD6z1xrAq0K2AQOX7CWIzf7id3hEuPiKDe0uUNRUMClFw3IWVwE7dHf+d48s
         MxR/4wBxrUoLCwngzb+vxBAMN+8zPDtMsLBDi5Y5N4xx4FPMpi7ZsFjO0cMaja82AMEe
         r95GV+oufC6FJXrvtziIwLDX1Rk/maUweFfyGGrYHr/i+HenVUBmml1W2PyIAE7F3kcQ
         vFT32n615qxCTtl+5eHA3WWagPxqypG9DCBw9YShIJbvwpGQS8KLqcJiefXnanZ2ZKzT
         pROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8rHy5dxRGESiSX8AnpAwnoYq2f6DwiON33y2JxbSAsk=;
        b=BZ82pkN9lD3ZBIi5nVL3HQZLtg2hJ+fFCgut+tkXxlsWfZ3QIL1Zwpuisw3LoHOFxt
         mZhL63WN6+qdTKfyddiOPFSE0/NO9GbDX//l/bMFQvF58Ouy+nf7kJ2DbF4xKY0EL2rI
         pRS5eXX52jBz5bPqJOYx0sirX17uHM0EaYjZdJASzSjzbowq9dFbPiSQa7TRTSuICYGF
         8DmKs5SM2GMuQstOXl9cBvP1acAtpRMKeuoAFNHFcqagIJE9XuAKLkX/g0WkvDu6azWv
         /UsMcVCgkOKskTaAHIzPSjeiUkVRIWLZ8aFdo2tqJQNolvNLymjnyA4urFgUVzfczTfX
         B2mQ==
X-Gm-Message-State: APjAAAWsffQXo7bXK09MZGgirDmqFAHiI8cK1MJASkvndG6s+jeOz6Eh
        bVH/Gc5Xa5NZbovs/gLHWuk=
X-Google-Smtp-Source: APXvYqwGK99ofGOG93BbRJhtbgeKuX4MpxeNBVdKzC138g9NeglLU8EgRIlgny/ozUB3i5WfNLe1CQ==
X-Received: by 2002:a62:480d:: with SMTP id v13mr97036185pfa.125.1555594419860;
        Thu, 18 Apr 2019 06:33:39 -0700 (PDT)
Received: from [192.168.0.6] ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id y19sm3350127pfn.164.2019.04.18.06.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 06:33:38 -0700 (PDT)
Subject: Re: [PATCH] nvme: determine the number of IO queues
To:     Aaron Ma <aaron.ma@canonical.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, axboe@fb.com
References: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
 <a2f0a97e14b884dc1183db9cbdd6f4b520000ce3.camel@redhat.com>
 <096935354b16662eb481aeda1f48001ba489463c.camel@redhat.com>
 <e79703d5-3502-6519-a497-71b2b2a8768f@canonical.com>
 <99ab1942-9c38-695d-03dc-ea6eecb31217@gmail.com>
 <130f490e-e173-750d-994e-c00f7c0da080@canonical.com>
From:   Minwoo Im <minwoo.im.dev@gmail.com>
Message-ID: <fbc19fb1-5e2e-ff39-5295-f38195fb8d7c@gmail.com>
Date:   Thu, 18 Apr 2019 22:33:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <130f490e-e173-750d-994e-c00f7c0da080@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 9:52 PM, Aaron Ma wrote:
> 
> 
> On 4/18/19 8:13 PM, Minwoo Im wrote:
>>> Yes the IO queues number is 0's based, but driver would return error and
>>> remove the nvme device as dead.
>>
>> IMHO, if a controller indicates an error with this set_feature command,
>> then
>> we need to figure out why the controller was returning the error to host.
>>
>> If you really want to use at least a single queue to see an alive I/O
>> queue,
>> controller should not return the error because as you mentioned above,
>> NCQA, NSQA will be returned as 0-based.  If an error is there, that could
>> mean that controller may not able to provide even a single queue for I/O.
> 
> I was thinking about try to set 1 I/O queue in driver to try to probe
> NVME device.
> If it works, at least system can bootup to debug instead of just remove
> NVME device and kernel boot hang at loading rootfs.

If the controller returns error for that command, how can we assure that
the controller would support a single I/O queue ?

> 
> If you still concern this 1 I/O queue I can still set it as
> *count = 0;
> 
> At least we try all count, NVME device still failed to respond.
> 
> Regards,
> Aaron
> 
>>
>> Thanks,
>> Minwoo Im

