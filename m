Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5ADC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880FD21872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY/6cV7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfDLQM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:12:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42804 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDLQM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:12:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id w25so5362510pfi.9;
        Fri, 12 Apr 2019 09:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2j8BUcng0BwJmxMELQ9fVczmlAT/WBCK6nxFe8uX3w4=;
        b=VY/6cV7jFXJN+VI5kQu6aV/UCQZSuHhpb1UjdxNg/19uFHouW3/2HKjdLP/YC/Zdfn
         YFWXi4yQh4PxSXpjESu6wOJnT35Q6mGwwVKk5LvB6G0A1YokNZS9r0fLlKMwsv9OGblS
         olQZZWt2JhcWvuktRIHWCeql/J93l5RAAB/eRi4Pf2tOIu0TZGjTeGTnh/1UboeCu8+Y
         WxFCLCmReITPgXQm7bmobYDjHLcLq6lZw4rew+2q7mzwEO+otZhdeH+IFM4CSTvhS8gu
         pda6lSymDtbwxDV8Zw24AFcVgTJTlrTnOBZTDuEkM8jpY2AXcwCuGzf0bRS0SNsUswFG
         NMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2j8BUcng0BwJmxMELQ9fVczmlAT/WBCK6nxFe8uX3w4=;
        b=JRszre10l17ta84wYl/6wTrF0lcLl6dKQJHwTdiEpsCQBCO1mtaQRzpH5ijBXCWyYI
         6yqSoGOQReoh+16w1A211UCOQvPerZgjoexV8M4/94fXoiJh51zIR+rhfudv/NJIBnSd
         +ZSA3wVq39z8nuqY2NqDSmtVT4sjR53vSj64JR1P/r4bPrj5VmlsW1EXZlPtZD9nyADM
         qJhzIBzwGTJ+6djDABEHoYHFiZVa0TeeXgNc5pEyEVPcEO7Vb7h7FDbi0mmBOkde3nHd
         0s/cnZ3xTOv/M1Eqiegk7DXCtGgre4RKvshqekHFDOwCoW9U/GjY1xRLRISo2adMMia4
         11ow==
X-Gm-Message-State: APjAAAW2jigVLKNCA8MJWWJkZMGCQzdNaaabJRQdbOXSflRJlvDe15rp
        Qtfp1gkY+qyyobpeGzWbrA3uzku7
X-Google-Smtp-Source: APXvYqzlgQhXj11v8hPpOVHEl0vgqSzx0/7UQt1zJcBa3dDhwLJ+RJGk8OJeGm5efqOOlmZjVXglnQ==
X-Received: by 2002:a63:7c45:: with SMTP id l5mr54506453pgn.303.1555085575990;
        Fri, 12 Apr 2019 09:12:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b7sm123353710pfj.67.2019.04.12.09.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 09:12:54 -0700 (PDT)
Subject: Re: [PATCH v2 00/21] Convert hwmon documentation to ReST
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jean Delvare <jdelvare@suse.com>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <20190411124324.3ed62fad@lwn.net> <20190411174357.251904f5@coco.lan>
 <20190411210731.GA29378@roeck-us.net> <20190412100451.6fe49de7@lwn.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8514ff97-3167-3c89-3468-e247d14c5086@roeck-us.net>
Date:   Fri, 12 Apr 2019 09:12:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412100451.6fe49de7@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/19 9:04 AM, Jonathan Corbet wrote:
> On Thu, 11 Apr 2019 14:07:31 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>>> While nobody does such split, IMHO, the best would be to keep the
>>> information outside Documentation/admin-guide. But hey! You're
>>> the Doc maintainer. If you prefer to move, I'm perfectly fine
>>> with that.
>>>    
>>
>> Same here, but please don't move the files which are kernel facing only.
> 
> Well, let's step back and think about this.  Who is the audience for
> these documents?  That will tell us a lot about where they should really
> be.
> 

Most of them are for users, some of them are for driver developers. A few
are for both, though that is generally not the intention (and one may argue
that driver internal documentation should be moved into the respective
driver source).

> What I would prefer to avoid is the status quo where *everything* is in
> the top-level directory, and where documents are organized for the
> convenience of their maintainers rather than of their readers.  But
> sometimes I feel like I'm alone in that desire...:)
> 
I am fine with separating user pointing from kernel API/driver developer
guides, and I agree that it would make a lot of sense. As I said, please
just make sure that kernel facing files don't end up in the wrong directory.

Thanks,
Guenter
