Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039A2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D382D20661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfLCJFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:05:21 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53120 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCJFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:05:21 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8C2F528F78D
Subject: Re: [PATCH 1/2] x86_64_defconfig: Normalize x86_64 defconfig
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        fabien.lahoudere@collabora.com, guillaume.tucker@collabora.com,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20191202211844.19629-1-enric.balletbo@collabora.com>
 <20191202211844.19629-2-enric.balletbo@collabora.com>
 <CAJKOXPdJSLoEX7+34imGuZ6CEE5unajL=byb+h9VT3Bejc353Q@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <3355589d-0b0d-f30f-624c-0f781ee9cd8d@collabora.com>
Date:   Tue, 3 Dec 2019 10:05:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdJSLoEX7+34imGuZ6CEE5unajL=byb+h9VT3Bejc353Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Many thanks for your quick answer.

On 3/12/19 3:15, Krzysztof Kozlowski wrote:
> On Tue, 3 Dec 2019 at 05:18, Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> make savedefconfig result in some difference, lets normalize the
>> defconfig
>>
> 
> No, for two reasons:
> 1. If running savedefconfig at all, split reordering items from
> removal of non needed options. This way we can see exactly what is
> being removed. This patch moves things around so it is not possible to
> understand what exactly you're doing here...

Ok, makes sense, I can do it, but if you don't really care of having the
defconfig sync with the savedefconfig output for the below reasons or others,
that's fine with me.

The reason I send the patch is because I think that, at least on some arm
defconfigs, they try to have the defconfig sync with the savedefconfig output,
the idea is to try to make patching the file easier, but I know this is usually
a pain.

> 2. Do not remove options just because other select them in a blind way
> - via savedefconfig. As it turns out, some developers have different
> view on dependencies and they expect that defconfig *explicitly* pulls
> out necessary functions. IOW, they can safely remove any visible
> symbol dependency assuming that defconfigs are selecting this removed
> symbol explicitly. See:
> https://patchwork.kernel.org/patch/11260361/
> (commit which removed DEBUG_FS - Marek Szyprowski will bring it back,
> I think, and Steven Rostedt answer)
> 

Also makes sense, and I didn't know this. My purpose is only add support for the
options missing for Chromebooks. If patch 2 alone is fine and enough for that
purpose, that works for me, and I can just drop this patch from the series. I
only tried to do the right thing to add new options.

Thanks,
 Enric

> Best regards,
> Krzysztof
> 
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>  arch/x86/configs/x86_64_defconfig | 90 +++++++++++--------------------
>>  1 file changed, 30 insertions(+), 60 deletions(-)
>>
> 
