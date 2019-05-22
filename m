Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBC8C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB40217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558555092;
	bh=N1u4K8lAKvK0Jq4HH61ZLx1vb3onUcqf2p8+OIoV9qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q5vfS09KVkpyHZgr9XjXjLJqXHwp4YPRNNMCqErrAwVGvtANRMkMEU5jySmOL7MwA
	 7fWxE4GyUe4gcxmcSaeaCgXrSHTa8JP65sqLnXwJFkhKi+v1xcZXTl0aHAbte7QRz4
	 zEAH4RiYPskji0QbJFgOKLtVEn2sVT7JfaClzODY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbfEVT6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:58:10 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:35684 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730645AbfEVT6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:58:08 -0400
Received: by mail-pg1-f170.google.com with SMTP id t1so1854404pgc.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 12:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ti2gujd26XzQoLiTeDe8/05EiKdhekJsO0rEj6y07qw=;
        b=YVVvBPJSZWF2y52mZXCQ82X6XtwoE27KpQxN2e1+7/BLzpnkKzo4WfwtQlpW4DxZXC
         Z67wKIzeAiyJA1pQH5QV2tdY2eDnlhXJfsKd3LGeC8QvCUp05Qk2VaQAwwV5omSmetaF
         okHRkhvoLrJ4mQhv0koADAwvUFNggZR4F8Fpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ti2gujd26XzQoLiTeDe8/05EiKdhekJsO0rEj6y07qw=;
        b=dP70ReinqtFWEVUFSe+r4FR9r5Y4Ai376KGb6E1BjkjLUFgnyd5e29VGClNpkqrg43
         vBmJg5yyBye2PSsoU+ozNxjRoEEFZ0nSqbnBAavThJeqmLYCewpYqKf59YFcvsUbYUo2
         LPBhv+8asDkok+2Wildg6Rfau3L2WQp0a/j1SEqbCnXLYOLycRTtqzcW9QXUbdWP6sp6
         5KXZ9SM9nyRywR1MDUK3CrbsOyRdH61+bp/8Rg/ARcDw49sCCImfcy8/L8YDHlmhZ20Q
         2BKjOkWB8lF7Ov/hhaDrycK4kytlG4uX6yUO0TddIMP+Mn5mG3W/1vHYZJ/3Ddxe6LOw
         P0Cw==
X-Gm-Message-State: APjAAAWMwk1eMR2sGZB7xqQswssRFtSc2e5wpt0WuvSXHzRffPtdOJW9
        qQCTmCYcYk5DyP1RuyunPScjoIBmYUdTmw==
X-Google-Smtp-Source: APXvYqz4z3TuF7/ac+bExwZ2wU5kfchxpPVjwEREHBi7Mnvkm90pW5uwHRz4gWEmk2BfdPUU6stZzQ==
X-Received: by 2002:a65:5c8c:: with SMTP id a12mr92237071pgt.452.1558555087658;
        Wed, 22 May 2019 12:58:07 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id n1sm24742643pgv.15.2019.05.22.12.58.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 12:58:06 -0700 (PDT)
Date:   Wed, 22 May 2019 15:58:04 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: PSA: Do not use "Reported-By" without reporter's approval
Message-ID: <20190522195804.GC21412@chatter.i7.local>
References: <20190522193011.GB21412@chatter.i7.local>
 <7b7287463e830fa8d981dc440f8165622cbc628e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <7b7287463e830fa8d981dc440f8165622cbc628e.camel@perches.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 12:45:06PM -0700, Joe Perches wrote:
>> It is common courtesy to include this tagline when submitting 
>> patches:
>>
>> Reported-By: J. Doe <jdoe@example.com>
>>
>> Please ask the reporter's permission before doing so (even if they'd
>> submitted a public bugzilla report or sent a report to the mailing
>> list).
>
>I disagree with this.
>
>If the report is public, and lists like vger are public,
>then using a Reported-by: and/or a Link: are simply useful
>history and tracking information.

I'm perfectly fine with Link:, however Reported-By: usually has the 
person's name and email address (i.e. PII data per GDPR definition). If 
that person submitted the bug report via bugzilla.kernel.org or a 
similar resource, their expectation is that they can delete their 
account should they choose to to do so. However, if the patch containing 
Reported-By is committed to git, their PII becomes permanently and 
immutably recorded for any reasonable meaning of the word "forever."

Now, I'm pretty sure that a request to rebase git history to edit a 
commit message would be considered "unreasonable" under GDPR provisions, 
but a) it still eats up valuable time handling such requests and b) it's 
a consequence reporters are not aware of when they submit bug reports.  
So, my request to ask for permission before using "Reported-By" is not 
coming from any legal position, but from the perspective of courtesy to 
people submitting those reports.

-K
