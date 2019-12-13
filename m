Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB93C79DBE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E096A246B3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="dPYEoMmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfLMRJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:09:07 -0500
Received: from mout.web.de ([212.227.17.12]:60571 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbfLMRJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 12:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576256934;
        bh=3fafM85luIeaUiZGDLJEm7FlP1U6y7qUQnnD60iyOXU=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=dPYEoMmr+diFeNer7CS9no1pyyabGZUozgeSIGO3QxwqFZvgiUKz1M+/100lMtb+/
         C7Gh99HPoiZro7BACluWeTt6CJKVwvG2fXEg5rQsBO8LyG4QWWFNPNtjz6Pu9RpJIL
         lZwWoa9qfQCxfMZXUHFXSi8sqvdtqYa/hmIiRS8M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.16.254]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LeLKb-1hwMCO2tvZ-00q7EX; Fri, 13
 Dec 2019 18:08:53 +0100
Cc:     linux-kernel@vger.kernel.org,
        Anton Vorontsov <anton.vorontsov@linaro.org>,
        Colin Cross <ccross@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Navid Emamdoost <emamd001@umn.edu>,
        Tony Luck <tony.luck@intel.com>
References: <20191211191353.14385-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH] pstore/ram: Fix memory leak in persistent_ram_new
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8c374545-b493-3be8-3753-a6fdd574f82c@web.de>
Date:   Fri, 13 Dec 2019 18:08:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191211191353.14385-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:ECQQXKN/hqdvoWc8OfgrYnyZn7GuVHKDYRurrdzWwcwFeLml5VI
 oMzoTLLmFn4jkyECzSXoNHWPTLLN46hIM9I08HAap3nLBtSlSO1haF6niMMWFbJVWQ3DAZs
 FA4RGGtZ+E7wXjyTYFmMcIC6W3wtNiQkatsHOxoCPMpvtotLfywTT/ZZs8pnOhQGXlfo/9t
 XpFTEv8NfL3/lBlh03L+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0dGojxKQTQ8=:bRaT5054m55uHFuf1TU6i5
 W4tucAh/ZSI17lHvA++jOp9GSOTZKZ8Gmj8Pv1JGKigga2usuK9xbQdF3sSKHrDUZH6FRJTIV
 d4U0/QLQfooT8YmiupJ7MPIYEjzzxqyibaUi6g4m/rpHSPvZVu0akgbT5eHIAKOgKJXt59kyy
 b1BW9wIZSekmuvJHHhZaZh2OfZpWnNhaVrbx500sze2FUeSJ1mDL/RoH1F2bBNDrpGZJsxQ8v
 dWHZHntsRzlNueNc+IJ50kBVYv/X1pl3KGMxlPD2BllAwama1leqqQA+l2zqO0JrcOnQwN6HV
 oir6pQEhDYQGclRP1IW1Fe8xrwVi2ZdeMrVLUfJn8lt0dqxyjxzH7W2hGslM+mcxjOv10jqTg
 286qzS6XvwZlD3mK7qBcCeGbH+wDayePEWAHSxzVTfowK4DVFa5pNiDfl1VB2ZWqpwVqJhHXp
 ZgihQoIxt6y+KNuRDONzHr3DWLd8yzsUq3G74Aian+yehDWuthH2Hamh9RE5Y87yU9kiij5gH
 DZz8I32zqVYzGCrNLRYAmL491J5FF/oinKHOGj5aBHjzwPtt4XLDtppDNjP9KEudTldIxXS1e
 J6vD+TM2gSClfNqSAfR4tuTtleGWHe8uZKymdFpPmnSFl/rsofw3eCYkaAZ2uuoCGGK5uO83p
 Kqj7M60TSKqJK9fD3+f5iH+Moi76GNR/BzDCqocTqJVX+m9RvUw4wwLe4clNrhZwqAuzyyUIV
 YMHQ32P/+ZaFry2ygOx6vRJbzPzL2i6Kv/f08d49enxGU6mXAOjxuzNQakEpDuag/np1obhVJ
 /aIXYbspqVSHFzhEY8OVoyW1aI6xcSsaiRaaK5uCoBw7i115bvP76NAyClI74ctdv5VilWmJO
 WldPYawnLoCA9j3BRoCcyquWzBdQ1J2axaFD4Ryc/UIAJKn5R7tCpyYj1Qwko2GWJSNyKUWnV
 h7O3gz4uF5w33ldiSC+FzF8pqDa3ZvpMGh3j9O8U7uJDhI1iVbOFdgyorKJrb/D22Q9jM+IjW
 baDt1WPV8xraQiQ0EUnPQlY5tW9dJIGC7XhPPQeqBIC4ID+cm4vhjTcDMYPxT635aHU9nIT22
 GoQWAybKklULnGpX5APHUCxw3f8A8cEfL0hr+oLvLqJo/pzVK4z86zuYUT9bUSJvlInX/wOKe
 oqPSjGmbNiTV+5Oq0XL1nNfQSg/i3QzbGuxGSRhLQF6Gjf445XiC2sRqVX7VyxURAZrsEP+SQ
 y/TUWJdJGVNg2vpp1ZNqaJSjAuj4SrTiKth7PUtddaCAwu9W5jCblL1IHyd8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In the implementation of persistent_ram_new(), if the allocation for prz
> fails, "label" should be released as part of error handling.

How did you come to this conclusion?

I suggest to reconsider this patch because the mentioned string is passed by
a function parameter.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/pstore/ram_core.c?id=37d4e84f765bb3038ddfeebdc5d1cfd7e1ef688f#n561
https://elixir.bootlin.com/linux/v5.5-rc1/source/fs/pstore/ram_core.c#L561

I recognise other implementation details which could be improved here.
https://lore.kernel.org/lkml/97737d95-d6aa-d24f-1af0-9d4895ceaed2@users.sourceforge.net/
https://lkml.org/lkml/2017/8/16/645

Regards,
Markus
