Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AC8C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD812073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cimPOY7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfKOHoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:44:18 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46719 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfKOHoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:44:16 -0500
Received: by mail-lj1-f195.google.com with SMTP id e9so9586225ljp.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 23:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MerzeYQd7mMrWj7xug82ip0Zzuk57QC86rO5mCSsEzs=;
        b=cimPOY7g4EAlwVyfr4cwpdgRJdBwRgLjtx/sUwL01IBFA4qPtm6hLBgyIKILrFzJM9
         xiOtbLJf0y4FyFS5wuHNxaB4q8sFK2F7P67/5/RQWCsQ9oGFBnDTdc4D+B26iZzap9Qa
         gTUwq1Rz9t3IIvqDWNeazaS9zPcEWsGD6g1ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MerzeYQd7mMrWj7xug82ip0Zzuk57QC86rO5mCSsEzs=;
        b=fKO9FwzXy4vbytD3UM6jF2djNTuZTOXPbEoIK0L3H3+O9kvoLROyvSB3DABGddwFiZ
         3TNSK1GrcixiHOubVq/sBeWe5r/9otVl+4iU7Zj6etxx3qs6L48VU21Gk0aEp4BC5g8T
         mkNxqKC5OzqgC2Jqu9+UaFmBzwXS0pB90anDLnprG8QJf7VnoH1DgtpNkDpjI1jobW0z
         k62DtKPH99Y7SBvAhVMuBzQrkhlJeyvBKCzOFr51Tyw50AbHMEqnKYkKTM8Oeqs/Aq/k
         Plt2w0p//qI3j3m4Q0sUpGjqTRI1yS6320+jD4kfr7egXBOd8/rgM5vdfjh9bUp/OOGq
         ErbA==
X-Gm-Message-State: APjAAAVmrNbvjqPxlRLyZXZQwQV+GFRdjE3a04hn6Hixdw4Rd4dkP5c0
        Rkn4ELMrxjC5WK22jQuaZwjZ4w==
X-Google-Smtp-Source: APXvYqw8OAiLBu508szXHtSnz3QQioa3U2uijYFbTHFzEtm/A+7bHMI6CgvxmnwrGknlwyb2z4HUYw==
X-Received: by 2002:a2e:9784:: with SMTP id y4mr10091304lji.77.1573803854082;
        Thu, 14 Nov 2019 23:44:14 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id p19sm3689755lji.65.2019.11.14.23.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 23:44:13 -0800 (PST)
Subject: Re: [PATCH v4 45/47] net/wan/fsl_ucc_hdlc: reject muram offsets above
 64K
To:     Timur Tabi <timur@kernel.org>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>, netdev <netdev@vger.kernel.org>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-46-linux@rasmusvillemoes.dk>
 <CAOZdJXUibQ6RM8O4CfkYBdGsg+LMcE2ZoZEQ4txn2yvquUWwCA@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <79101f00-e3ff-9dd0-7a05-760f8be1ff69@rasmusvillemoes.dk>
Date:   Fri, 15 Nov 2019 08:44:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOZdJXUibQ6RM8O4CfkYBdGsg+LMcE2ZoZEQ4txn2yvquUWwCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2019 05.41, Timur Tabi wrote:
> On Fri, Nov 8, 2019 at 7:04 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> 
>> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
>> index 8d13586bb774..f029eaa7cfc0 100644
>> --- a/drivers/net/wan/fsl_ucc_hdlc.c
>> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
>> @@ -245,6 +245,11 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
>>                 ret = -ENOMEM;
>>                 goto free_riptr;
>>         }
>> +       if (riptr != (u16)riptr || tiptr != (u16)tiptr) {
> 
> "riptr/tiptr > U16_MAX" is clearer.
> 

I can change it, sure, but it's a matter of taste. To me the above asks
"does the value change when it is truncated to a u16" which makes
perfect sense when the value is next used with iowrite16be(). Using a
comparison to U16_MAX takes more brain cycles for me, because I have to
think whether it should be > or >=, and are there some
signedness/integer promotion business interfering with that test.

Rasmus
