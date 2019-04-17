Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C597AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8286C21850
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/O9UniV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfDQLTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:19:53 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54494 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731116AbfDQLTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:19:52 -0400
Received: by mail-it1-f194.google.com with SMTP id a190so3894502ite.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 04:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zL3ujD0ba0NC1sL8I7Ofi1ph8V1pWVw7w8Ags394cdI=;
        b=x/O9UniVSSUtV1C/i+CeTfikdv66X/F6q8nW1mlhkl/cd8eNhhI9CjXopkedEcnW3z
         P9ObRkDE8oxHHscuI+MI9ALhKyeiFESQ5kfEV5DmRJJ79zk7qaXLq7shg3Mf9AGZRVGV
         /rQPrqx/GEGEQ+5krSnVODvbykedcXIa857zYlr1HeJH3y4yQse0SM00lIK0xEx83wSo
         qHavaCrjj5DWeSe7F4o5bsDs/lSIvQsn5FF/0DbWUKzYqhsQz0I6rSeNAjZ/lTz72JoP
         ILjokNbwUYG7jRVQ/HB8XOOlg3JhqqgLxQbecentR5F++5murvdn0KAJ5jQfJsRp5WrC
         KF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zL3ujD0ba0NC1sL8I7Ofi1ph8V1pWVw7w8Ags394cdI=;
        b=kv9gigjZrYp3b33nz4LcSctEyGy9zIqK+oBite6KmRMuWB8JKJ2mHeVWThVPvNNedx
         jY43+FqgVOwJWQZ+dn9BqmLndXiBy9x7fQb9BVLQ4PHvnBdt/RSBo/xWwos12bYpLVD4
         WSW1SjRsz3vk4VGn+ihhWsDnCkpbfcWcfkt76pAyYrP94NdAy/R4Na8mbqBopTJlfi1u
         JftUQrXhbD+eJb88Udqq844Y70WLUpueLi3afnHtHb+gVCw7BkKshhQcjdybQ1eR8skm
         j3kE9lMrDuUDguJdCLntYKGruYxszIXhmyvUIipjN3DQJFT0clZ7qDFqByRbzpM5H573
         fBNQ==
X-Gm-Message-State: APjAAAVAtGVogDLnemb38S/NaVQA/UMfvcqUe4UK3ghag7zL9dpegebQ
        S5cWBjoAxtjSSWnkU5DcvIkJD0rLjas=
X-Google-Smtp-Source: APXvYqz8wBrooWxx+B74gWaV43ojRuYuU3uzMH5VN0v+7EWRwlDQY2jviFPZQXRxH6y/59MVqm5s5g==
X-Received: by 2002:a02:658b:: with SMTP id u133mr53582582jab.17.1555499991568;
        Wed, 17 Apr 2019 04:19:51 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id r74sm1098436ita.7.2019.04.17.04.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 04:19:51 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH v2] Staging: greybus: Cleanup in greybus
 driver
To:     Greg KH <gregkh@linuxfoundation.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>
Cc:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org
References: <20190416221318.21161-1-madhumithabiw@gmail.com>
 <20190417062518.GA23076@kroah.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <a6bb72ed-5f98-86fd-33a3-8d68942eeae2@linaro.org>
Date:   Wed, 17 Apr 2019 06:19:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417062518.GA23076@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/19 1:25 AM, Greg KH wrote:
> On Tue, Apr 16, 2019 at 05:13:18PM -0500, Madhumitha Prabakaran wrote:
>> Fix a blank line after structure declarations. Also, convert
>> macros into inline functions in order to maintain Linux kernel
>> coding style based on which the inline function is
>> preferable over the macro.
>>
>> Blank line fixes are suggested by checkpatch.pl
>>
>> Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
>>
>> Changes in v2:
>> - To maintain consistency in driver greybus, all the instances of macro
>> with container_of are fixed in a single patch.
>> ---
>>  drivers/staging/greybus/bundle.h    |  6 +++++-
>>  drivers/staging/greybus/control.h   |  6 +++++-
>>  drivers/staging/greybus/gbphy.h     | 12 ++++++++++--
>>  drivers/staging/greybus/greybus.h   |  6 +++++-
>>  drivers/staging/greybus/hd.h        |  6 +++++-
>>  drivers/staging/greybus/interface.h |  6 +++++-
>>  drivers/staging/greybus/module.h    |  6 +++++-
>>  drivers/staging/greybus/svc.h       |  6 +++++-
>>  8 files changed, 45 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/staging/greybus/bundle.h b/drivers/staging/greybus/bundle.h
>> index 8734d2055657..84956eedb1c4 100644
>> --- a/drivers/staging/greybus/bundle.h
>> +++ b/drivers/staging/greybus/bundle.h
>> @@ -31,7 +31,11 @@ struct gb_bundle {
>>  
>>  	struct list_head	links;	/* interface->bundles */
>>  };
>> -#define to_gb_bundle(d) container_of(d, struct gb_bundle, dev)
>> +
>> +static inline struct gb_bundle *to_gb_bundle(struct device *d)
>> +{
>> +	return container_of(d, struct gb_bundle, dev);
>> +}
> 
> Why are we changing this to an inline function?  The #define is fine,
> and how we "normally" do this type of container_of conversion.

I'm not completely sure about the inline function, but on the no blank
lines thing (and many other minor issues) "checkpatch.pl" is to blame.
There are lots of examples of issues that checkpatch points out that are
matters of opinion and not hardened kernel style rules.

We try to encourage people to get involved with kernel development by
fixing minor problems, and we tell them a good way to find them is
by running checkpatch and "fixing" what it reports.  Unfortunately,
it is often things of this type, and reviewers balk and say "no,
please leave it," and the poor new person has a bad first experience.

I *like* "checkpatch.pl".  And the fact that it can point out some
of these sorts of things is great.  But it would be nice if certain
types of problems (like multiple blank lines, or lines that are 81
characters wide for example) would only be reported when a "--strict"
option or something were supplied.

					-Alex

> I understand the objection of the "no blank line", but this was the
> "original" style that we used to create these #defines from the very
> beginning of the driver model work a decade ago.  Changing that
> muscle-memory is going to be hard for some of us.  Look at
> drivers/base/base.h for other examples of this.
> 
> thanks,
> 
> greg k-h
> _______________________________________________
> greybus-dev mailing list
> greybus-dev@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/greybus-dev
> 

