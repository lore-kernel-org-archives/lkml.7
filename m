Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72011CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5254421721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403877AbfJ1QsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:48:03 -0400
Received: from webclient5.webclient5.de ([136.243.32.184]:55093 "EHLO
        webclient5.webclient5.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403866AbfJ1QsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:48:02 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Oct 2019 12:48:01 EDT
Received: from olorin.ladisch.de (x2f7f95e.dyn.telefonica.de [2.247.249.94])
        by webclient5.webclient5.de (Postfix) with ESMTPSA id 7F6BC5583F65;
        Mon, 28 Oct 2019 17:40:32 +0100 (CET)
Subject: Re: [PATCH] ALSA: usb-audio: Fix memory leak in __snd_usbmidi_create
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Navid Emamdoost <emamd001@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Stephen McCamant <smccaman@umn.edu>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20191027221007.14317-1-navid.emamdoost@gmail.com>
 <s5hpnihmlk3.wl-tiwai@suse.de>
 <CAEkB2ESwKEQYQx75BnaHf4aUQHObx4jf0hreQx_KTeZ+QCjL4g@mail.gmail.com>
From:   Clemens Ladisch <clemens@ladisch.de>
Message-ID: <d623a621-c62a-7ae9-958c-8709fb0c8c7d@ladisch.de>
Date:   Mon, 28 Oct 2019 17:38:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAEkB2ESwKEQYQx75BnaHf4aUQHObx4jf0hreQx_KTeZ+QCjL4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.4 at webclient5
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Navid Emamdoost wrote:
> On Mon, Oct 28, 2019 at 1:27 AM Takashi Iwai <tiwai@suse.de> wrote:
>> On Sun, 27 Oct 2019 23:10:06 +0100,
>> Navid Emamdoost wrote:
>>> In the implementation of __snd_usbmidi_create() there is a memory leak
>>> caused by incorrect goto destination. Go to free_midi if
>>> snd_usbmidi_create_endpoints_midiman() or snd_usbmidi_create_endpoints()
>>> fail.
>>
>> No, this will lead to double-free.  After registering the rawmidi
>> interface at snd_usbmidi_create_rawmidi(), the common destructor will
>> be called via rawmidi private_free callback, and this will release the
>> all resources already.
>
> Now I can see how rawmidi private_free is set up to release the
> resources, but what concerns me is that at the moment of endpoint/port
> creation umidi is not yet added to the midi_list.
> In other words, what I see is that we still have just one local
> pointer to umidi if any of snd_usbmidi_create_endpoint* fail.

The snd_rawmidi device is automatically registered with the card, so the
line "rmidi->private_free = snd_usbmidi_rawmidi_free;" is the exact point
where the ownership of umidi changes.  midi_list does not matter.


Regards,
Clemens
