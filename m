Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EABAC2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 03:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81D1206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 03:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="K0RxkoMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfLaDX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 22:23:58 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:44797 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfLaDX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 22:23:58 -0500
Received: by mail-ot1-f47.google.com with SMTP id h9so46114075otj.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 19:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L/kyvGEr4uFHwqPQpgEhZ4Erg6RCGEqxRCpdwHQ8Tzw=;
        b=K0RxkoMR1SxSz92rdlVNSCOmbgPOXNLYNoYvxEug/RW+dBv9STcmr0PV4CCqxiMFgZ
         0NcPklQNGyWSu5GwZQs9lkkUb2oL9Zn8c7AQZPWZccA4gQJ9E+CqN8H9zVX5KeLSdNnv
         kAerLuoZxrKEwXucwITB95zhL///GD18dqdlOcEWoNgb0WrdyY+8QabzO1d/7B64QCrp
         APrDSeDIJUFtK8fW6sS4MzqwMGyW4MIF76Ae8FQhEJIFpMKutDBkKV46hWbVUaFBm8gP
         0coTCJ4bpvLG82/mefMkdM4LmYO5pdhDVv9n0o/rmaBwRKHf5ri1mxlQt22/KVAu0Q/8
         wZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L/kyvGEr4uFHwqPQpgEhZ4Erg6RCGEqxRCpdwHQ8Tzw=;
        b=TG0wKASPmDn2NtVNhLEg9CtIhNWBuTc9cOQdnrHyAJUWKS53jAzDAB4+Fs6o5zKu+/
         T96LD493YFPpBnbLi+0IVfzWmSKJs72iewBR5G6XvXoI3FCOtZRM4Iyzbm7lR3Q5AVj/
         HhHnSdblrJE7Jp6twyDDdD2/zKAkM9s/RJ2/jDmaIMgov8998PkMs95JiXIVDQ3Z2IrI
         ++wYPfXvCu+sU87bMyw0TUOCfHhaMYMEevVXrLZu8nEyfCnSLOU3fItJ0b3thp+GrAKt
         KPOZG/9i5+fuNeqpmKxTAsyAxxNwdmUCMinRWPTB5pPoYK2rugkok+QrdkEp/y7GQ6Ri
         /N/w==
X-Gm-Message-State: APjAAAVn4nYI3xWU58Kg7sEaXMTRKVZJwpssJpXnrDQ2AordTngVRm9+
        XzhBEoAtYP80FM0ggLXpweapajfq7KQ=
X-Google-Smtp-Source: APXvYqwRr7cHPIt0G74QZbOzuRXJuFFCK3qI4s/R9tBt1+o4/rH2gev1hmm6cosqUtj9alfBohXCUw==
X-Received: by 2002:a05:6830:110a:: with SMTP id w10mr80837829otq.300.1577762637213;
        Mon, 30 Dec 2019 19:23:57 -0800 (PST)
Received: from ?IPv6:2605:6000:e947:6500:6680:99ff:fe6f:cb54? ([2605:6000:e947:6500:6680:99ff:fe6f:cb54])
        by smtp.googlemail.com with ESMTPSA id m89sm15269464otc.41.2019.12.30.19.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 19:23:56 -0800 (PST)
Subject: Re: Why is CONFIG_VT forced on?
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <9b79fb95-f20c-f299-f568-0ffb60305f04@landley.net>
 <b3cf8faf-ef04-2f55-3ccb-772e18a57d7b@infradead.org>
 <ac0e5b3b-6e70-6ab0-0c7f-43175b73058f@landley.net>
 <e55624fa-7112-1733-8ddd-032b134da737@infradead.org>
 <018540ef-0327-78dc-ea5c-a43318f1f640@landley.net>
 <774dfe49-61a0-0144-42b7-c2cbac150687@landley.net>
 <20191231024054.GC4203@ZenIV.linux.org.uk>
 <20191231025255.GD4203@ZenIV.linux.org.uk>
From:   Rob Landley <rob@landley.net>
Message-ID: <ffa8ec1d-71d7-a153-eed9-8e2daee40949@landley.net>
Date:   Mon, 30 Dec 2019 21:27:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191231025255.GD4203@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/19 8:52 PM, Al Viro wrote:
>> Rob, if you are in a mood for a long wank, it's your business.  But try to avoid
>> spraying the results over public lists.

I don't post regularly here anymore, but it's good to see the code of conduct
and Linus's sabbatical have had a positive effect on the place in my absence.

> To elaborate: you are complaining about VT being treated the same way as e.g.
> ELF_CORE or UID16.  Which might or might not be reasonable, but kconfig folks
> have nothing to do with that.
>
> Your complaint is basically that the same thing is forcing all of those on
> in default configs.

No, my complaint was that kconfig basically has the concept of symbols that turn
_off_ something that is otherwise on by default ("Disable X" instead of "Enable
X"), but it was implemented it in an awkward way then allowed to scale to silly
levels, and now the fact it exists is being used as evidence that it was a good
idea.

I had to work out a way to work around this design breakage, which I did and had
moved on before this email, but I thought pointing out the awkwardness might
help a design discussion. My mistake.

The thread _started_ because menuconfig help has a blind spot (which seemed like
a bug to me, it _used_ to say why), and then I found the syntax you changed a
year or two back non-obvious when I tried to RTFM but that part got answered.

> Instead of having a separate ROB_WANTS_THOSE that would
> prop the rest, but not VT (and frankly, quite a bit of that rest is
> questionable for minimal setups).  With ROB_WANTS_THOSE (or equivalent
> information) enshrined in the kernel tree for your convenience.
>
> Pardon me, but... why is that anyone else's problem?

You drove everybody away who would express similar concerns years ago. None of
my co-workers have wanted to get linux-kernel on them in ages. (I thought that
sort of thing was why you were having a code of conduct and such, but apparently
not.)

*shrug* I'll try to be more proactive about stripping linux-kernel from the cc:
list once I've got a human's attention in a thread. (Or just try to dig up
somebody to email directly via git history and the maintainers file.)

I leave you to your sexual metaphors,

Rob
