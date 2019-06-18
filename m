Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5636DC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2879A20873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560870281;
	bh=GLkzNmB11mIMqXWKKDlm+xnN5jJVONf5DNID/7gX8dM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=CyXRLlol2nSmB1E8wr73UGyeO6m8gfOv4M7T4YW6l5CZA91aNTvwfMNOxU+HFCvFj
	 aj0aWAATF9QJXvxShbDM55zoW+Idk1Yqht+z2kQ0GpQ1CaHMqpCFF9J5ZD+HNXqHWp
	 x40pdsouD2mLrBkXfzWDlZl6SOWD+fHO3xZPnfME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfFRPEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:04:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37858 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfFRPEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:04:39 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so30662783iok.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n+Ql3wVC/12fF84n4zpf2k7UpDcKmujEt1DaiiPw9qM=;
        b=S5z34YtusjYEDrmJRpYdDkLNkEyqZu2h0VztZzhWaBFSPMcfGjsfL4fPxA8epFlCl0
         7EYgCFMMMOJi+6eDL60CzSqoLl22mrz9wj837Byc3ao3hmvAIEgkqvGh252sQt+oHfQJ
         88csRkNqH6wPqPa8M6QrcTns38DwR0C+hDyr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n+Ql3wVC/12fF84n4zpf2k7UpDcKmujEt1DaiiPw9qM=;
        b=ZMlONPUDLODm5ZO8UvNISADjBdvB6N2oYIZr8j7rZWHDCzMZvUZVQQGAWwafo25zZf
         5wMIIDm8J8XWEM+o7nyRLBSJiwKBu/++d1VGQJYKEyZmG6+/anlrNcgFV+Rqejg4Cjq5
         i78uZNq0+0ghmlVzz6hznCBU0rwyxY8fUIiE0DgUlbVM4fQhUjCtGZwzgfM2h7zrNfiI
         RtvLr12HjhDR6UgfOtRlIyIWszhPDSC6ZoxDfJOmlNUpsuTq/9shKDWAlX1ZfLzQ3RQt
         MEATOwbqHWNl7OyUI7oSLuW1tJk5x9ntEBSHcTEqaFX8hJAYi3BX2QDzF3eQ6Yn6Cyq6
         WZog==
X-Gm-Message-State: APjAAAX051GZyhOfDDbgZ8ff5SU4utQ0rK02tauYQPbG6zAQaBzpS4eo
        M7VIUbFemweNejwxRwWi34BiLQ==
X-Google-Smtp-Source: APXvYqxj0KuCDj3+zY6rRSN6uEABJMKSdM9JnxVOi3emiC+fs8zDQXFdWYHimb0In4JQsTwcp1rg4g==
X-Received: by 2002:a5e:a712:: with SMTP id b18mr6336031iod.220.1560870278397;
        Tue, 18 Jun 2019 08:04:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n7sm16602070ioo.79.2019.06.18.08.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 08:04:37 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees] [PATCH] Documentation: platform: convert
 x86-laptop-drivers.txt to reST
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, cezary.jackiewicz@gmail.com,
        Darren Hart <dvhart@infradead.org>, andy@infradead.org,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20190618053227.31678-1-puranjay12@gmail.com>
 <20190618054158.GA3713@kroah.com> <20190618071717.2132a1b7@lwn.net>
 <20190618133948.GB5416@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8aeb222a-ee44-4125-45fd-ce9a741e7ecc@linuxfoundation.org>
Date:   Tue, 18 Jun 2019 09:04:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618133948.GB5416@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/19 7:39 AM, Greg KH wrote:
> On Tue, Jun 18, 2019 at 07:17:17AM -0600, Jonathan Corbet wrote:
>> On Tue, 18 Jun 2019 07:41:58 +0200
>> Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>>> On Tue, Jun 18, 2019 at 11:02:27AM +0530, Puranjay Mohan wrote:
>>>> This converts the plain text documentation to reStructuredText format.
>>>> No essential content change.
>>>>
>>>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>>>> ---
>>>>   Documentation/platform/x86-laptop-drivers.rst | 23 +++++++++++++++++++
>>>>   Documentation/platform/x86-laptop-drivers.txt | 18 ---------------
>>>>   2 files changed, 23 insertions(+), 18 deletions(-)
>>>>   create mode 100644 Documentation/platform/x86-laptop-drivers.rst
>>>>   delete mode 100644 Documentation/platform/x86-laptop-drivers.txt
>>>
>>> Don't you also need to hook it up to the documentation build process
>>> when doing this?
>>
>> Hooking it into the TOC tree is a good thing, but I think it's also good
>> to think about the exercise in general.  This is a document dropped into
>> place five years ago and never touched again.  It's a short list of
>> seemingly ancient laptops with no explanation of what it means.  So the
>> real question, IMO, is whether this document is useful to anybody and, if
>> not, whether it should just be deleted instead.
> 
> I bet it should be deleted, but we should ask the platform driver
> maintainers first before we do that :)
> 

Adding Platform driver maintainers Darren Hart and Andy Shevchenko, and
Compal laptop maintainer Cezary Jackiewicz to the discussion.

+ platform-driver-x86@vger.kernel.org

Hi Darren, Andy, and Cezary,

Would it be okay to remove the x86-laptop-drivers.txt or should it be
converted to .rst and kept around?

thanks,
-- Shuah





