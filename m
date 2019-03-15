Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE015C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC4221871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mathtm.de header.i=@mathtm.de header.b="Knzwm/SS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfCOUVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:21:15 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:18490 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfCOUVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552681268;
        s=strato-dkim-0002; d=mathtm.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=0ifRgTzX3nf6OmDFiqVjqSX9JADkticdYBzTIE/1w5g=;
        b=Knzwm/SSEdNhb2Y0EL+lOBJGKs2qTC0vdrdybHHh/CcsjKLm3a5y/trWSIt+JIEm5B
        H9OciEfsiMmcTj8m6+F7RxBlXmJ8uv4b24IBqDXaFU+tP7lVrFe04FJPs2D5dwCQXAuo
        fmkSNwFwSiTBg5g5fpjUZi8qwvZFh8Xps6FOOVMU93K36jX4JTqHuK3T2VqF87B8OMXn
        L37UQTcGzJSDtCNfMz7QwBzk1cVcBjOqTmn05tGKpLZpm/FPnjx8+f6M13ht3aoLSy6z
        R9aB6zcYrpyCzl3JyMxnkIglHUAmxmp/LZQLJOpGTRwkxuUCkUhsHY6RzGv7jCTACYyi
        ga3Q==
X-RZG-AUTH: ":OGQLeEG7W/KAXU7xLV2hdHgxFRdqbfEqQfblTbv8grSYpDW1Eaj6FvvOcjigVdGPh5DhF+qnevIOn9P3RmBEJvyulaz8y/n6Yk8="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2003:cb:3740:e000:a481:fc47:16dd:4cc6]
        by smtp.strato.de (RZmta 44.16 AUTH)
        with ESMTPSA id e091ffv2FKL26ZN
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 15 Mar 2019 21:21:02 +0100 (CET)
Subject: Re: disabling secondary CPU hangs / system fails to suspend with
 kernel 4.19+
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
References: <5c48095e-028a-404f-aaa1-964f83c83817@mathtm.de>
 <20190315090950.GT5996@hirez.programming.kicks-ass.net>
 <cbaafd35-a17d-8331-4cef-281a562b91b5@mathtm.de>
 <20190315121541.GD6058@hirez.programming.kicks-ass.net>
From:   =?UTF-8?Q?Thomas_M=c3=bcller?= <thomas@mathtm.de>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas@mathtm.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2b1c85d3-d94b-1593-e30a-a32d97043579@mathtm.de>
Date:   Fri, 15 Mar 2019 21:21:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315121541.GD6058@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 15.03.19 um 13:15 schrieb Peter Zijlstra:
> On Fri, Mar 15, 2019 at 12:41:00PM +0100, Thomas Müller wrote:
> 
>>> What .config do you have?
>> The one packaged by Fedora. I've attached the one for 4.20.15 as reference.
> 
> Thanks, I'll have a poke, see what, if anything, is different from the
> kernels I ran.
> 
>>> And what, if anything do you see on the
>>> console when it goes funny?
>> Nothing unfortunately.
>> When trying to suspend the display immediately goes blank, the system becomes unresponsive and the
>> status LED within the power button start flashing rapidly (just like it does when the power cord is
>> attached).
>>
>>
>>> I think you wrote that hot-un-plug never completes? Is there anything in
>>> dmesg when it's stuck in:
>>>
>>>   echo 0 > /sys/devices/system/cpu/cpu1/online
>>>
>>> ?
>> I've just tried that again and the system immediately froze.
> 
> Hmm, I tought you said the system remained semi usable, just that reboot
> stopped working thereafter and it needed a power cycle.
> 
>> `journalctl -f` was running in a second window but it had no chance to output anything... :/
> 
> Ah, you're using a GUI!
> 
> Stop doing that ;-)
Easier said than done ;)

> See if you can use the VGA console; not a FB console or a DRM console,
> but the real ancient, proper text mode, VGA console.
I've just re-tested with runlevel 3.
Not a real VGA console, but at least no Wayland or Gnome to interfere...

`echo 0 > /sys/...` just blocks and no message whatsoever is visible in dmesg.

I've executed `echo 0 > ...` in the background to keep my console functional and I can e.g. echo
something to /dev/kmsg and it shows up, so reading/updating the log buffer appears to be working
just fine.
A power cycle is still necessary to recover the system.


> Now, don't ask me how to do that, because I don't know, I've been
> running on pure serial console output for the past 10 years or so, heck
> I don't even have systemd.
> 
> And you might have to do something like: dmesg -n8, to get the console
> to print the kernel messages or something.
> 
