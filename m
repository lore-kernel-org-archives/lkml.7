Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548A1C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DA12080C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbfFSL1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:27:00 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:41491 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727076AbfFSL1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:27:00 -0400
Received: from [IPv6:2001:983:e9a7:1:bdf4:9145:f694:e7a2] ([IPv6:2001:983:e9a7:1:bdf4:9145:f694:e7a2])
        by smtp-cloud9.xs4all.net with ESMTPA
        id dYjvh2hHlbiAgdYjyheMFA; Wed, 19 Jun 2019 13:26:58 +0200
Subject: Re: [PATCH v7 1/3] media: cec: expose HDMI connector to CEC dev
 mapping
To:     Dariusz Marcinkiewicz <darekm@google.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190521105203.154043-1-darekm@google.com>
 <16889839-b4e9-9984-2e36-5f07ceb7d7f2@xs4all.nl>
 <CALFZZQEao3vqVxKO-3mT5ATtC=ZWO+bc3dA_Xo-mgpqmna_fMQ@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <4566a4db-86db-c9ee-3a5b-9e7c605a6da7@xs4all.nl>
Date:   Wed, 19 Jun 2019 13:26:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALFZZQEao3vqVxKO-3mT5ATtC=ZWO+bc3dA_Xo-mgpqmna_fMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLkiYeyCJf1TKqZF4vspGS3CifNDj+TT6iXem0j8+Co+mmDALh0Wo01sebLcyd43TWXrpMQ8KqYsK4W0nZqoF8Cv0OMoxSk+q1Hn4fhLlBS5MVLewuWY
 QB/MZenDXYHRZJpMrkusiXYOwTmMhe6O3LXfgosMTjasx9oduewuM6Su1khYV4fsdTFhmhEbAX28s7qpHwPMXcptwnE1HZ4HsBTtnjmNRjexCJvtBmJQB0xH
 1/ANUcQOk84J67DjTCeksJp4xkXCEqrBmhstueB6oNB/EZSbo9mBvOk8JcI6eWJMb6Nogl2RqGLkP+m/GoRR1gonnpuvY/i2Y7oLogfHfs5yxcGs61gl3C8y
 BCmN7pko
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/19 1:05 PM, Dariusz Marcinkiewicz wrote:
> Hi Hans.
> 
> I would like to come back to this thread.
> 
> On Fri, May 24, 2019 at 11:21 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> Hi Dariusz,
>>
>> I did some more testing with the Khadas VIM2 and found another problem,
>> something that will, unfortunately, require some redesign.
>>
>> See my comments below...
>>
> ...
>>
>> Another issue here is that when the HDMI driver removes the notifier,
>> then it should also zero the connector info. Remember that both the
>> HDMI and the CEC drivers can be loaded and unloaded independently from
>> one another.
>>
> 
> I took a peek at the changes in
> https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=cec-conn. Do I
> understand it correctly, that the above problem is addressed there by
> unregistering an adapter in cec_notifier_conn_unregister (which will
> result in /dev/cecX node going away)? I wonder to what degree this
> solves the problem of HDMI and CEC drivers being loaded and unloaded
> independently. It seems that in cases where HDMI driver is unloaded
> and then loaded again, counterintuitively, the /dev/cecX might not
> come back again, is this right, or am I missing something? Also, is it
> guaranteed that adapter drivers won't try to access an adapter once it
> gets removed by cec_notifier_conn_unregister?

It's old code, I'm going to do it differently (closer to your version,
actually).

I just pushed my latest code, I'm much happier with it.

I'll try to post a patch series this week.

Regards,

	Hans
