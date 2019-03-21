Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190BCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D2321901
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfCUNO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:14:29 -0400
Received: from ns.iliad.fr ([212.27.33.1]:40928 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728249AbfCUNO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:14:28 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 58865202A3;
        Thu, 21 Mar 2019 14:14:26 +0100 (CET)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 413551FF37;
        Thu, 21 Mar 2019 14:14:26 +0100 (CET)
Subject: Re: [PATCH v2] nvmem: core: Set no-read-write provider to avoid
 userspace read/write
To:     Gaurav Kohli <gkohli@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>
References: <1552831940-7327-1-git-send-email-gkohli@codeaurora.org>
 <48a71861-c60b-7fe7-d4af-5269cd7c20eb@linaro.org>
 <5f11070f-bf9b-c313-9a78-e412a2fb2908@codeaurora.org>
 <865519b5-62c9-3eb3-3855-eebf98bded85@linaro.org>
 <68755fdb-b2c6-ac25-a786-7593a692a173@codeaurora.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <7a1e8f27-9e24-985a-531b-26122077752f@free.fr>
Date:   Thu, 21 Mar 2019 14:14:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <68755fdb-b2c6-ac25-a786-7593a692a173@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Mar 21 14:14:26 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2019 18:50, Gaurav Kohli wrote:

> On 3/20/2019 9:56 PM, Srinivas Kandagatla wrote:
> 
>> Am guessing these are some kind of keys or something that you do not 
>> want user to see.
> 
> Yes exactly, there are certain keys or even certain bit that we don't 
> want to expose to user.
> 
>> Is root only option not helping you in this case?
>
> Yes we want to protect at root level as well, I mean it is better if we 
> can avoid exposing to userspace at all.

NB: root has access to /dev/mem and /dev/kmem (and probably other ways
into the kernel)

>> We could go down the route of adding new config option something like 
>> CONFIG_NVMEM_NO_SYSFS_ENTRY to prevent adding nvmem entry in userspace.
>>
>> Let me know if you are happy to create a patch for this change?
> 
> I am happy with either way, config option or DT binding (seems easy),
> please let me know we will post new patch for the same.

Device tree nodes are supposed to be hardware descriptions. Obviously,
implementing security policies such as "hide this information from
user-space" is not a good fit for a DT node.

The qcom kernel is full of "config knobs" in DT nodes. It would be good
if you could spread the word, and slowly turn things around :-)

Regards.
