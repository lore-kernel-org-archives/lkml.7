Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE3CC41514
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF65C20856
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566940579;
	bh=u30Uz09Wx2ggUD73DFEm5M/io8JmvBjC1sc4Al1XFHQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=xxxy90E+QAJxU73J3PSkrbZYlINinQQaVf7NYchEBCnnah/9qGWQliKR3cCeDcC44
	 Ffy4QyPDNR3IQcS4XrtPh2LHK0oMVEhP5lFpe2F4gscx9+PVxlg5WJBHDBQxd+DS1u
	 se8UQt0hI84AQe+RdFdNW1+6JrvGk+PqZy2I+ro4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbfH0VQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfH0VQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:16:17 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17F052077B;
        Tue, 27 Aug 2019 21:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566940576;
        bh=u30Uz09Wx2ggUD73DFEm5M/io8JmvBjC1sc4Al1XFHQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IAgAkU2nr5hXEHlEhoptezUoZexB8Usy+XlQ9/QA/yLIyVcuZoLA+roUi38RfFU/0
         mMxHWf8D+IsNFj56WNGfCFmuniMm8jEvTI/VCfyH/k/eKBQv6HTIEVmEIYiBl9Wy1s
         hIAjsrdq8c0wPdj9++BGGhi0zQwDOZEVgKvAZymc=
Subject: Re: [PATCH v1] kunit: fix failure to build without printk
To:     Randy Dunlap <rdunlap@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        shuah <shuah@kernel.org>
References: <20190827174932.44177-1-brendanhiggins@google.com>
 <ae9b9102-187c-eefe-d377-6efa63de2d28@kernel.org>
 <5b626f60-8472-a97e-378e-755160e5d948@infradead.org>
From:   shuah <shuah@kernel.org>
Message-ID: <15c04ce1-020f-a286-07fe-c1b883c44b1b@kernel.org>
Date:   Tue, 27 Aug 2019 15:16:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5b626f60-8472-a97e-378e-755160e5d948@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/19 2:53 PM, Randy Dunlap wrote:
> On 8/27/19 1:21 PM, shuah wrote:
>> On 8/27/19 11:49 AM, Brendan Higgins wrote:
>>> Previously KUnit assumed that printk would always be present, which is
>>> not a valid assumption to make. Fix that by ifdefing out functions which
>>> directly depend on printk core functions similar to what dev_printk
>>> does.
>>>
>>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>>> Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
>>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>> ---
>>>    include/kunit/test.h |  7 +++++++
>>>    kunit/test.c         | 41 ++++++++++++++++++++++++-----------------
>>>    2 files changed, 31 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/include/kunit/test.h b/include/kunit/test.h
>>> index 8b7eb03d4971..339af5f95c4a 100644
>>> --- a/include/kunit/test.h
>>> +++ b/include/kunit/test.h
>>> @@ -339,9 +339,16 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
>>>      void kunit_cleanup(struct kunit *test);
>>>    +#ifdef CONFIG_PRINTK
>>
>> Please make this #if defined(CONFIG_PRINTK)
> 
> explain why, please?
> 
> thanks.
> 

This can be used to do compound logic. I have been using this style for
that reason starting a couple of years now. I seem to work in code paths
where I have to look for multiple config vars.

In this case, it probably doesn't matter as much either way.

thanks,
-- Shuah
