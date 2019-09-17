Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB42C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62996214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bitmath.org header.i=@bitmath.org header.b="i54V4mb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfIQSjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:39:17 -0400
Received: from mailrelay4-2.pub.mailoutpod1-cph3.one.com ([46.30.212.3]:55583
        "EHLO mailrelay4-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbfIQSjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:39:17 -0400
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Sep 2019 14:39:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitmath.org; s=20140924;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=2QCEbDkNTVlepmxfafwkDO+VtRnQKigkL8ILiS9erYo=;
        b=i54V4mb44f3KPaPCXXwcmOKK2reosPHOkefCdH94bX4dNRBYrfF6vas3EfbFXDr9IV4wufI8IYY5D
         LEem8usf73om5pI1FU64FkRNrxlIcSmx0K6QgG7iEaaMvFvSTEmB7PqBpWPiOeLYFHG+0QtP23y4ZT
         lOwCjXHS6ngQrvT8=
X-HalOne-Cookie: 3202c1e5ddf8ba5138876360452462549f22ef0d
X-HalOne-ID: 34d1a670-d978-11e9-8285-d0431ea8bb10
Received: from [192.168.19.13] (unknown [98.128.166.173])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 34d1a670-d978-11e9-8285-d0431ea8bb10;
        Tue, 17 Sep 2019 18:23:11 +0000 (UTC)
Subject: Re: [PATCH v3 02/49] Input: introduce input_mt_report_slot_inactive
To:     Jiada Wang <jiada_wang@mentor.com>, nick@shmanahar.org,
        dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190917093320.18134-1-jiada_wang@mentor.com>
 <20190917093320.18134-3-jiada_wang@mentor.com>
From:   Henrik Rydberg <rydberg@bitmath.org>
Message-ID: <546c8205-ecb7-1c34-3727-b10c7ff86232@bitmath.org>
Date:   Tue, 17 Sep 2019 20:25:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190917093320.18134-3-jiada_wang@mentor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiada,

> input_mt_report_slot_state() ignores the tool when the slot is closed.
> which has caused a bit of confusion.
> This patch introduces input_mt_report_slot_inactive() to report slot
> inactive state.
> replaces all input_mt_report_slot_state() with
> input_mt_report_slot_inactive() in case of close of slot.

This patch looks very odd, I am afraid.

When a driver needs to use input_mt functions, it first calls 
input_mt_init_slots() during setup. The MT state then remains in effect 
until the driver is destroyed. Thus, there is no valid case when 
input_mt_report_slot_state() would fail to execute the line

    input_event(dev, EV_ABS, ABS_MT_TRACKING_ID, -1)

when active == false.

What input_mt_report_slot_state() does do, however, is to ignore the 
event when no MT state has been set, which does happen for some drivers 
handling both normal and MT devices. Changing such a driver in the way 
you suggest would introduce new events in existing, working cases, and 
possibly break userspace. We should try very hard to avoid it.

Thanks,

Henrik


