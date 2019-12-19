Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FEDC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA71C227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cmz6/G6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfLSP5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:57:20 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34732 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLSP5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:57:19 -0500
Received: by mail-yw1-f68.google.com with SMTP id b186so2343782ywc.1;
        Thu, 19 Dec 2019 07:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yhTnmr/VJ4AJ01HwBs+ZAFD8EOFGnGlia8f2h6iSFZU=;
        b=Cmz6/G6Y0m1HQmz2q1FxdrA1SpVCmyT5uistLN2Y24TZilQKfjH+fhteww874a3ra9
         DGTXyMz09ohrtHGgtt1chZC8K0UsPLuAz9yQgazxEJ+e+EEjL8wPtlGYVnMCAyPih7ne
         DGpgMjjpXE8PuQukl1MDMvXU6lMAjjhrMew1MeWLZMaftt4ZBHqHfqkH979EkocjXTTN
         pzBKD7iQ49xDx/m24/3xpSCC6SoLH6vL0frB2jfEtpTHeRaHFe7YVFtwIsF/MvZPLuci
         jpuYNIdysuDUtdBsZ6zdpzzIW2emDBRrHP/5T7LaQXMeYs48+CFGGyHL27HgzPsg5ENl
         JJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yhTnmr/VJ4AJ01HwBs+ZAFD8EOFGnGlia8f2h6iSFZU=;
        b=V+CoVL6by+hEuBjeMhxlMJIwHn58Y2V/dA3xQe2l4/FBczu74kBbxwoLbUk+l3obKk
         MzT2SWkIYIhytlPhRa74JnFge8ecKMwYVIaO0DUkrhFa8lO7Di2jgGFjhgW2Zz3X9znM
         PwGszYfivt5Rn6rmvxD4WVbMGrLJnsJsvXAKM6Xfc/c3fCED8GWP+Vd2WtjoYS0+xsNZ
         RAWK0AaRaiGuwerP5SvvlC6Wy7hcyq7VyZA2FYQO4UOHgDOud5VUoB12TBQS9zqU/4iF
         SLLq1DFNmeoBHMh83VdS3qlJz0qfvNhxHhsZ0gTnCMClWmxMbYhwcqNrULC8cdh+0T6H
         +vjg==
X-Gm-Message-State: APjAAAVtJaYK+5j/s30NbbM8puYBqVgtCWcI/qOC1xtEfHuLBeFVniJx
        mafjfcWrxu4WdaDMf0YeTrNaBIGV
X-Google-Smtp-Source: APXvYqwdVAFztUWBozK65C6Q3f4EkdIlyHUGHM2EtcVxhXPRSezFuunMsLNz/5bHo6m0IM4CU7FvXg==
X-Received: by 2002:a0d:eb92:: with SMTP id u140mr7076375ywe.6.1576771038781;
        Thu, 19 Dec 2019 07:57:18 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id y206sm2704594ywa.102.2019.12.19.07.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 07:57:18 -0800 (PST)
Subject: Re: [PATCH] of: refcount leak when phandle_cache entry replaced
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <1575965693-30395-1-git-send-email-frowand.list@gmail.com>
 <20191211201856.GA21857@bogus>
 <486ce60c-8a74-7baf-1054-c81c83e79e56@gmail.com>
 <CAL_JsqL_0UUrjPG3G4vzO5fzzREV4tr5Y+ykRxzU+Cqz4_YgdQ@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <1b02de95-acd2-5acd-4427-b89ec2cb5119@gmail.com>
Date:   Thu, 19 Dec 2019 09:57:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL_0UUrjPG3G4vzO5fzzREV4tr5Y+ykRxzU+Cqz4_YgdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 8:00 AM, Rob Herring wrote:
> On Thu, Dec 12, 2019 at 5:17 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 12/11/19 2:18 PM, Rob Herring wrote:
>>> On Tue, 10 Dec 2019 02:14:53 -0600, frowand.list@gmail.com wrote:
>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>
>>>> of_find_node_by_phandle() does not do an of_node_put() of the existing
>>>> node in a phandle cache entry when that node is replaced by a new node.
>>>>
>>>> Reported-by: Rob Herring <robh+dt@kernel.org>
>>>> Fixes: b8a9ac1a5b99 ("of: of_node_get()/of_node_put() nodes held in phandle cache")
>>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>>> ---
>>>>
>>>> Checkpatch will warn about a line over 80 characters.  Let me know
>>>> if that bothers you.
>>>>
>>>>  drivers/of/base.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>
>>> Applied, thanks.
>>>
>>> Rob
>>>
>>
>> If the rework patch of the cache that you posted shortly after accepting
>> my patch, then my patch becomes not needed and is just extra noise in the
>> history.  Once your patch finishes review (I am assuming it probably
>> will), then my patch should be reverted.
> 
> The question is what to backport: nothing, this patch or mine? My
> thought was to apply this mainly to backport. If you're fine with
> nothing or mine, then we can drop it. I'm a bit nervous marking mine
> for stable.
> 
> Rob
> 

Your rework patch is slightly larger than what is preferred for stable,
but it is more likely that future patches to the files in the rework
patch will be able to be applied to stable.  So I am happy with
either nothing or your patch.

-Frank
