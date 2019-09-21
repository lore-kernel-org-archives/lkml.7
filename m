Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7B3C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 06:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160B020882
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 06:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="evkEodFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfIUG4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 02:56:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45045 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfIUG4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 02:56:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id i18so8790524wru.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 23:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=G+3UPEhERrKETlk0FsuOwaqKLSxXjoLtJQ8TkFpUanQ=;
        b=evkEodFPsQCy9q6aV3S9m0L2g7DE6Jx4M0MnI0imvyxJMf176t1gVqZYI3GQbP0Ww9
         2lD47ST6Shv9mG6w0mER4CKLC+uBdRfcdMal7Qqp21MqL2IOZry3tch/Or5s+nez9jo/
         x4Zc6AW2/ZdQ4WTW3QnN994vYcNDJtJm/Lj98TlUV42VFytLSWzKJTK7qCUT7ONxKX8l
         18O9Hax99+RMyOmpzbHROpEnGpRuL3tItse+yn0TYvtYP6y3dUNF4GpyLMWcYN3KXAda
         8dH9eS2f50YIRSPt3C6QxBRVCBBqZISO60GiNPJ22ZdB1/6Oyi3FrNQH0N+z43kOn5CF
         NPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=G+3UPEhERrKETlk0FsuOwaqKLSxXjoLtJQ8TkFpUanQ=;
        b=cbMV/FyvQR0ASl5og3h32OudbH3dxw5FTdEbAb1uD+INSw3sS/mlj+NfH1r/Vl98O6
         v7iEPF+h2YYc+RH1eaBcld/aeNOfdObxkSv5qBs5b0WZKiHc+m0R5y4kdjsLNmJ0PToH
         XzUgMoYuIR5RylVY/qHlDHjDCp93huPxnaPa+28WxeNmxm5rbm4ULpOsIln3JrxoVsS6
         tlDpVTd1Ulmgu+JvN0x5lL4l+nwGciGLhC7lY6cqR+Qv1BnHWnYszMDmRrLJr+zTVKRL
         /hnR5Rnv9vJIP7xQQ2sGNSv0j8VfjS3lGlNOov6N60iAQ+BdZsfJxV/XkEhsWzizjwnv
         Zhhg==
X-Gm-Message-State: APjAAAWmiZMFssJuBwcaoG9E4UdScIbQOPG6Pyd3+/+D9j5uWbS3eAdw
        EechVLIYiN7tpODLULerGFHS7Q==
X-Google-Smtp-Source: APXvYqxdZx+s8oTyrgehe/A1WhysotelpvIxih1/tgzaNr0jhrn7B0FxHmF/LqmoiE/tJ4KwzD7I9A==
X-Received: by 2002:adf:f008:: with SMTP id j8mr15366854wro.75.1569048961373;
        Fri, 20 Sep 2019 23:56:01 -0700 (PDT)
Received: from [192.168.0.102] (146-241-16-18.dyn.eolo.it. [146.241.16.18])
        by smtp.gmail.com with ESMTPSA id q15sm7958160wrg.65.2019.09.20.23.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 23:56:00 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 2/2] block, bfq: delete "bfq" prefix from cgroup filenames
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <de7664b1-6f47-8a7b-b231-727336c0ef85@kernel.dk>
Date:   Sat, 21 Sep 2019 08:55:53 +0200
Cc:     Tejun Heo <tj@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        cgroups@vger.kernel.org, Angelo Ruocco <angeloruocco90@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE1AEF80-F07F-42DE-A979-BC5AE72B25A1@linaro.org>
References: <20190917165148.19146-1-paolo.valente@linaro.org>
 <20190917165148.19146-3-paolo.valente@linaro.org>
 <20190917213209.GK3084169@devbig004.ftw2.facebook.com>
 <4D39D2FA-A487-4FAD-A67E-B90750CE0BD4@linaro.org>
 <20190918151948.GL3084169@devbig004.ftw2.facebook.com>
 <4F416823-855F-4091-90B9-92253BF189FA@linaro.org>
 <A87FEC8A-3E1A-4DC8-89F7-5FAF63CF5B47@linaro.org>
 <de7664b1-6f47-8a7b-b231-727336c0ef85@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 20 set 2019, alle ore 15:05, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 9/20/19 12:58 AM, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 18 set 2019, alle ore 18:19, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>>=20
>>>=20
>>>=20
>>>> Il giorno 18 set 2019, alle ore 17:19, Tejun Heo <tj@kernel.org> ha =
scritto:
>>>>=20
>>>> Hello,
>>>>=20
>>>> On Wed, Sep 18, 2019 at 07:18:50AM +0200, Paolo Valente wrote:
>>>>> A solution that both fulfills userspace request and doesn't break
>>>>> anything for hypothetical users of the current interface already =
made
>>>>> it to mainline, and Linus liked it too.  It is:
>>>>=20
>>>> Linus didn't like it.  The implementation was a bit nasty.  That =
was
>>>> why it became a subject in the first place.
>>>>=20
>>>>> 19e9da9e86c4 ("block, bfq: add weight symlink to the bfq.weight =
cgroup parameter")
>>>>>=20
>>>>> But it was then reverted on Tejun's request to do exactly what we
>>>>> don't want do any longer now:
>>>>> cf8929885de3 ("cgroup/bfq: revert bfq.weight symlink change")
>>>>=20
>>>> Note that the interface was wrong at the time too.
>>>>=20
>>>>> So, Jens, Tejun, can we please just revert that revert?
>>>>=20
>>>> I think presenting both io.weight and io.bfq.weight interfaces are
>>>> probably the best course of action at this point but why does it =
have
>>>> to be a symlink?  What's wrong with just creating another file with
>>>> the same backing function?
>>>>=20
>>>=20
>>> I think a symlink would be much clearer for users, given the =
confusion
>>> already caused by two names for the same parameter.  But let's hear
>>> others' opinion too.
>>>=20
>>=20
>> Jens, could you express your opinion on this?  Any solution you and
>> Tejun agree on is ok for me.  Also this new (fourth) possible
>> implementation of this fix, provided that then it is definitely ok =
for
>> both of you.
>=20
> Retaining both interfaces is arguably the right solution.

So you also are voting for BFQ to create two files, instead of having a
symlink, aren't you?  I just want to be certain before submitting one
more solution.

Looking forward to your confirmation,
Paolo

> It would be
> nice if we didn't have to, but the first bfq variant was incompatible
> with the in-kernel one, so we'll always have that out in the wild.
> Adding everything to stable doesn't work, as we still have existing
> kernels out there with the interface. In fact, in some ways that's
> worse, as you definitely don't want interfaces to change between two
> stable kernels.
>=20
> I know it's not ideal, and some better initial planning would have
> made it better, but we have to deal with the situation as it stands
> now.
>=20
> --=20
> Jens Axboe

