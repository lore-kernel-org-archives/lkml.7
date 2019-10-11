Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C239AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0442C214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="TW5X1Faw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dv8mhG6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfJKADl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:03:41 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37555 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbfJKADl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:03:41 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0B7B0220BA;
        Thu, 10 Oct 2019 20:03:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 10 Oct 2019 20:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=u
        Rr/kFsIZaHy8HYqLPJ1ymRYxil+0WCAOjr/vPbR/yI=; b=TW5X1FawG9/vU9ewM
        rj+MktaT10lfOWvseyOQw8LeApUvz/hXJGIc4BssTigcyN50+4QEavXZjyh/gaFo
        pvUbU6CtieOnRC1AoiTVdtm0fWQfjdrgebdM1YZ95qAOINSKAEyDLZ7+ZErWXo4W
        MpmJ4D4dNotk4Ki7vIFWMitrMw0lEsHJvbEGpOg2QjU2i9I371OOxWXRijtftH1x
        rEL92mOceX0XDaZLe2ybetFcuQYBr8k49SY1y70XQ2xVLWRhA33FODjrgY4V9BnX
        1+/ghsAPqHTW4d5bV65FZEtxaF0Y6mMWVaFk/FFQf3mpp9zAGfDNuzdn2RSXo8G5
        wXJpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=uRr/kFsIZaHy8HYqLPJ1ymRYxil+0WCAOjr/vPbR/
        yI=; b=dv8mhG6bkghcqQrxe6LT3iLVXIOTLUuxDBvF6Lz3abzYR/Xrz+FU2sd/z
        urBBpIXQLWSDelgvaRRqyLpQgJffRzJEyqSruTd9OYbGNhxezyzRf3pFJPWm8Gcc
        nZ5PdUkjM5hF4heeWSFVqBYx9nG4lKCKVIeXqrpyA/HgVKBsJLmgyIhRSEwV9amU
        exMjCym7z/5j3RjIZ6LAaQwkD7Q1SOFIKtPxSA0ojcqKI0GexoVNwF7djlR8KS6C
        yFanffc0IFJUTnLh81eMQBBEA2fZs4WNKV7coU0cBcBGbi1aSnH+9Y5CNBZ3AUvj
        8DUmGs6TqXDlr4ZQlx2mdG2qxgAPA==
X-ME-Sender: <xms:28afXduWUYsZFSvy7-SvT5CMydLKpkswjPGFojPb-ygTVzbXIpxvYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrieeggddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:28afXZ1RLSi-zSTIlCLOUhaJubk7CT7GjYbCBEoBRB3urDvyE3pqKg>
    <xmx:28afXcDgYWYmt_J7euix69o6uNQqa76PcC72VFUKjQWflJGKJP3zyA>
    <xmx:28afXVuhVW-qkndwC7uJ0bTLqQk2Ep1w1CDkV3zGRRS-JU_YKNLM4w>
    <xmx:3MafXWFKE1pyeLy5tXkk-Tr7PaqPbjqWAl6hlEFSLm6nx9nieJS_LA>
Received: from [192.168.50.162] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0386A8005A;
        Thu, 10 Oct 2019 20:03:38 -0400 (EDT)
Subject: Re: [PATCH 2/2] firmware: coreboot: Export active CBFS partition
To:     Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Zhang <benzh@chromium.org>,
        Filipe Brandenburger <filbranden@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20191008115342.28483-1-patrick.rudolph@9elements.com>
 <20191008115342.28483-2-patrick.rudolph@9elements.com>
 <5d9d120b.1c69fb81.b6201.1477@mx.google.com>
 <CAODwPW-mfySMQUejCwT+G45BtOysq_JCRQa8GwoYTkjY_yRwgA@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <b14dd18b-e737-b7dd-77db-023a4b379802@sholland.org>
Date:   Thu, 10 Oct 2019 19:03:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAODwPW-mfySMQUejCwT+G45BtOysq_JCRQa8GwoYTkjY_yRwgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/19 4:19 PM, Julius Werner wrote:
>> Somehow we've gotten /sys/firmware/log to be the coreboot log, and quite
>> frankly that blows my mind that this path was accepted upstream.
>> Userspace has to know it's running on coreboot firmware to know that
>> /sys/firmware/log is actually the coreboot log.
> 
> Not really sure I understand your concern here? That's the generic
> node for the log from the mainboard firmware, whatever it is. It was
> originally added for non-coreboot firmware and that use is still
> supported. If some other non-coreboot firmware wants to join in, it's
> welcome to do so -- the interface is separated out enough to make it
> easy to add more backends.
> 
> I do agree that if we want to add other, more coreboot-specific nodes,
> they should be explicitly namespaced.
> 
>> But I also wonder why this is being exposed by the kernel at all?
> 
> I share Stephen's concern that I'm not sure this belongs in the kernel
> at all. There are existing ways for userspace to access this
> information like the cbmem utility does... if you want it accessible
> from fwupd, it could chain-call into cbmem or we could factor that
> functionality out into a library. If you want to get away from using
> /dev/mem for this, we could maybe add a driver that exports CBMEM or
> coreboot table areas via sysfs... but then I think that should be a
> generic driver which makes them all accessible in one go, rather than
> having to add yet another driver whenever someone needs to parse
> another coreboot table blob for some reason. We could design an
> interface like /sys/firmware/coreboot/table/<tag> where every entry in
> the table gets exported as a binary file.
> 
> I think a specific sysfs driver only makes sense for things that are
> human readable and that you'd actually expect a human to want to go
> read directly, like the log. Maybe exporting FMAP entries one by one
> like Stephen suggests could be such a case, but I doubt that there's a
> common enough need for that since there are plenty of existing ways to
> show FMAP entries from userspace (and if there was a generic interface
> like /sys/firmware/coreboot/table/37 to access it, we could just add a
> new flag to the dump_fmap utility to read it from there)
There's already a node in sysfs for every coreboot table entry:

  /sys/bus/coreboot/devices/corebootN

where N is the index of the entry in the coreboot table. I suggest

1) Rename the devices based on their tag instead of their position in the table,
   so the names are stable and meaningful. I don't know why I didn't do that in
   the first place. Doing that gives you a device kobject you can hang
   additional sysfs attributes off of.
2) If we want userspace to have access to the raw binary table entry (which
   sounds like a good idea to me), add that sysfs attribute in
   coreboot_table_populate() after creating each device. That way it would be
   present regardless of whether or not there's a specific driver loaded for
   that table entry.

This solves the immediate problem of needing /dev/mem to access coreboot tables,
while leaving open the possibility of writing kernel drivers in the future if
that would be more beneficial than parsing the data in userspace (i.e. if the
kernel can do something more with the data than just exporting it).

Samuel
