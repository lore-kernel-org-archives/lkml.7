Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D864C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90D92084B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfD2M62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:58:28 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:58397 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfD2M61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:58:27 -0400
Received: from [192.168.1.110] ([77.9.18.117]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N6KMR-1gjiq62ZhJ-016j4B; Mon, 29 Apr 2019 14:57:03 +0200
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without
 UPF_BOOT_AUTOCONF
To:     Esben Haabendal <esben@haabendal.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        He Zhe <zhe.he@windriver.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190426084038.6377-1-esben@geanix.com>
 <20190426084038.6377-2-esben@geanix.com>
 <20190426143946.GX9224@smile.fi.intel.com> <871s1og11u.fsf@haabendal.dk>
 <20190426215103.GD9224@smile.fi.intel.com> <87tvejakot.fsf@haabendal.dk>
 <CAHp75VfZMuQ3xagGSt6dXv1tZbSfanUdaw0SgjTqq3YET5YBKQ@mail.gmail.com>
 <87y33tz5oz.fsf@haabendal.dk>
 <CAHp75Vc6cLnLztXtvTcWisjAqDUTEWBBgv20CA34ZQmBEAvpbA@mail.gmail.com>
 <87ef5lxiqm.fsf@haabendal.dk>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <a84da0ff-8f61-75a9-e91f-550fb70a3f5a@metux.net>
Date:   Mon, 29 Apr 2019 14:56:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87ef5lxiqm.fsf@haabendal.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Xi8+kN3ggy0q8UqlVr1mLGr8tMECSCR4gGXzRpXnZEKUZYiwx2o
 HhfmKEnGaURE5cshKsrrdPF76Oc0UxXE1prabduHmA1hGT7P0K+DuQdw8yV71LqE8tOiFiu
 5aLrpYObZMDq4NrxNifckSW7PHUQ+5/WWBxP/TddhRQMK76RCMUKcebpdIVT2cMSEo3mlIU
 Nmx01LhrSuW/OuY5vmRNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lUPD7tiF4iY=:3HMXJNqzKnQgJJNa0/hYLA
 y8oOBd4maeBkvhV0Bpy0xL/kkHLEb85rglY1FxVy/UkM9uwGZxyslvdf+2boltKtvoDc8Sv+n
 kSVoJoCLShJLGsK0/IMa6ALrCvkNHFaryiSvxEMYl9f3iWpFCdsJCeBXcgvicnTgxRQP9xCDN
 FrRlWpbQDGb1RjRQomTAZlNoa8DahUrzn918C01Yemz1q0iktKluHJgglG/4eUGpdsSB9k4bG
 p5OnJskSzmTIVmKfrWMXYLVA2FE1l0zYaGyzBKjIACKc/7Y5mGymGhGusCcNwPYEY5q6KeTIl
 mjqioKKcDSSqAtdl3kZuILYKrvsHNYwDwnniQ0UkATL19magrZ9zXezcocg+Za4o5nLVukgg9
 8FmFYNGPSYqNoKyyj4VwRwO7vJ3gBpfduNbhQF518XQJoS2nt2Bvg7SSVqiUpUJhPzRaXGuoT
 OL2A+6QjOqff7lpaw3pq9MYT44cqIW7LmI2nTpufSOXT/2KFLfJ3HJaD6aRXj8XWPdXaxwLJB
 oX6CKXd2n9XRsd52rj3mciqWcAAbY7NwcK4o13aRjwfBlGP6ntoOBxFpAe3ilOoT3DCm/3BhG
 rL3xKmvPoCrCYxAU7Y1GLTCgz4l9U+4hE45xjhaWsLpeu00q5afpK2PTjIITaD1MN2PJr5iyN
 XbWdRdYcmWTkKCUMdcSJUlkhcuWrjKXtUlkuDo7dbvGgs4RlWaokTcpqRhldzFSWO6JqOCrzW
 BkN1vpmErmz+Vi+I3ANGvWIhtity3zqn+XK2mRh3UK6Ll75HB47GHy+bDA60IKvAUnP+32ifN
 2Ie4IJXRyqjeRxPyc94RTE6osbUT5XMQxfmz1zOWMK/So2iMnI/iH7Nnw3Qg4y05nirQfjh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.19 11:29, Esben Haabendal wrote:

> So maybe we should go down that direction intead, extending 8250 driver
> to replace mapbase with a resource struct instead?

Yeah, I already was up to do that. But that would be a pretty massive
change, as the actual use of fields like mapsize/mapbase in the drivers
is so diverse. Some even don't use mapsize.

That's why I started harmonizing that step by step. In little steps,
that are easier to review (unfortunately, don't have the corresponding
hardware to do real tests).

Finally, I'd like to have all drivers just use appropriate helpers to
declare their IO area and let the core do all the mapping stuff. Then we
IMHO could easily switch to struct resource internally.

> No, I actually try to do the right thing in relation to Linux device
> resource model.  But 8250 is just not behaving very well in that
> respect, not having been made really aware of the resource model.

I see it the same way. The serial (especially 8250) drivers are a tricky
thing, and I'd like to make it simpler / easier to understand.

But I can understand that Greg is pretty reluctant to any changes, as
some actual hardware seems to be hard to get. (OTOH, if it's so rare,
could we risk some potential breaks and just wait for anybody
complaining ?)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
