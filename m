Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D59C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B1620675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfCGUhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:37:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40856 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCGUhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:37:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id g20so10471130wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 12:37:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ciakIFypHhbfberMmeiRPKsknDYsjGvDxtVRFiP5ZW4=;
        b=GXCi+J4rHxqgGRFm7TX8CgXMy7w+FFayNTlJbtYxvzGntZliHEOBvU2mnUGuJRw//o
         QCmqYNS74KAENIWYLm818QD6LLb5ht7klqtb3er9YnTccFb4moNrL0pUiPHccSQmVudf
         4f1k4IRj70rbVYaW9EsR+ZJOzveHb7dK8Zv+RwYWS4wnjTbN2xMpxwWd6m0zOch6+m9E
         MUVWCbVLVr+8glZ5PpBFCf5WtH+tAH25Jmmkm94kUp94ANgtqjfWjci2Sb/ICLGAEHYl
         wQSjTsI4OHM2tNMMPdUWeid66Iz7r81hC7VMs8trEGNjcKp1NQ/TexS8+cpl91i6vapz
         1gdw==
X-Gm-Message-State: APjAAAVUOJttge143mtE0gqKZqByv2uhUbpOlRuxhv/mMgOsRLHd/Vmr
        6nccNof78/8ZKb9YNTqz7JbxYg==
X-Google-Smtp-Source: APXvYqzgnTwX5NvTE3/K/pGt5QsbOQC6GU5OhxbGvIinRZIXL0Rsb5wf3MMD312IAqU0WrQiGnIiqA==
X-Received: by 2002:a7b:cb8e:: with SMTP id m14mr6370274wmi.64.1551991052620;
        Thu, 07 Mar 2019 12:37:32 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a131sm7469946wmh.34.2019.03.07.12.37.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 12:37:31 -0800 (PST)
Subject: Re: [PATCH 0/2] ata: libahci: devslp fixes
To:     Gwendal Grignou <gwendal@chromium.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tejun Heo <tj@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, alan.cox@intel.com,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        rajatja@chromium.org
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
 <9712316ab62bef25953c523bce02e260a9ea40fe.camel@linux.intel.com>
 <20180730152256.GF1206094@devbig004.ftw2.facebook.com>
 <bf4b860c-6f82-4a3f-8b81-5f5c93f4389e@redhat.com>
 <20180730173345.GI1206094@devbig004.ftw2.facebook.com>
 <CAMHSBOVOK15nchZRFGTZUu8KSbBiK3SFzgW1amLjXb1iv_gJ5g@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <54d2b8e6-332b-117a-b982-77a535152246@redhat.com>
Date:   Thu, 7 Mar 2019 21:37:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAMHSBOVOK15nchZRFGTZUu8KSbBiK3SFzgW1amLjXb1iv_gJ5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07-03-19 21:27, Gwendal Grignou wrote:
> Srinivas,
> 
> I am looking at problem on a laptop machine that suspends to S01x, but
> link_management is set to max_performance, because the machine is
> connected to a charger.

What is setting it to max_performance when charging?  I assume chrome-os is
running something in userspace to do this (like TLP, but I guess you are not
using TLP) ?

Have you run benchmarks with max_performance vs the default?
I seriously doubt there will be a significant difference, esp.
with a chrome-os style workload.

> Given DVLSP must be set before the laptop suspends ["""One of the
> requirement for modern x86 system to enter lowest power mode  (SLP_S0)
> is SATA IP block to be off."""], the machine never reaches S01x.
> Does it make sense to change the target_lpm_policy at suspend
> (ata_port_suspend()) to min_power and bring it back to the original
> value on resume?

If userspace messes with the setting, then userspace should also
put it back before suspending...

The upstream kernel's default behavior is to have the target level set
to a fixed level independent of the charging state. Could it be this
fixed level is actually max-performance ? If that is the default the
kernel comes up with, that would indicate a kernel bug.

Regards,

Hans



> 
> Gwendal.
> 
> 
> On Mon, Jul 30, 2018 at 10:33 AM Tejun Heo <tj@kernel.org> wrote:
>>
>> On Mon, Jul 30, 2018 at 05:26:45PM +0200, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 30-07-18 17:22, Tejun Heo wrote:
>>>> On Mon, Jul 30, 2018 at 08:15:47AM -0700, Srinivas Pandruvada wrote:
>>>>> Hi Tejan,
>>>>>
>>>>> On Mon, 2018-07-02 at 12:01 -0700, Srinivas Pandruvada wrote:
>>>>>> Some minor fixes to be able to correctly set devslp register
>>>>>> to optimize power.
>>>>>>
>>>>>> Srinivas Pandruvada (2):
>>>>>>    ata: libahci: Correct setting of DEVSLP register
>>>>>>    ata: libahci: Allow reconfigure of DEVSLP register
>>>>>>
>>>>> Are you applying this series?
>>>>
>>>> I was waiting for Hans's reviews.  Hans, what do you think?
>>>
>>> Ah I missed that this was another series. With the caveat that
>>> I do not really know that much about devslp, both patches
>>> seem sensible to me, so both are:
>>>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Applied 1-2 to libata/for-4.19.
>>
>> Thanks.
>>
>> --
>> tejun
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
