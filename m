Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99A6C10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2F120850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH1Zelfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfDMAwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 20:52:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36928 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDMAwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 20:52:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id w23so5893603ply.4;
        Fri, 12 Apr 2019 17:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FAOFcqGmAyWqRgqK+hze86G4KUWhAcKaMXCl1prsD7U=;
        b=WH1ZelfwVnWq8wfRpDlMD10uUdU4Yzwvl2MVee4roCocPTsQszssvpu7mYqNa7S26u
         hqkFJQYJZLikHqgzZ7GxIYc25grjdbXDF92YLkUCGkFIy6fj+f8c/63ver9r867/734G
         FgP+MqH/EjOOnF6DrHfr5w1JXmds0Rvo98YNl3tc67TRnEKqfgoshit9eXFZ+2eWfaCe
         FtJg1pyFnhHK/T7VzvYSZjcWMtOrLxkRFTT2fj+VUa3EuPZC9WzzsexiAH1PB7UbjsfU
         iGa42KAtl0SWUaxzxebYjUV5Tk/rzCAihMnzZAL+0hSTK3AssYuDL+VAR/DVBEsYAnkT
         uxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FAOFcqGmAyWqRgqK+hze86G4KUWhAcKaMXCl1prsD7U=;
        b=RjyXnWV8OyzNJGJhueu8fJxHYomqLkiFdVCYOf/aK9J2jfzypqaGmWl9PuR0AtB9Cb
         3xB91tULeXhFi82hmGbxYa5Jd0vTxtrk8EdFoDBwDUsaaxKfUU56beDZE1R2RQ1IhxfD
         q4JOKhsFEJUbscGPZEsr5QMIb6KOi2yUfU5qM+vuZ0unQXXpjzanSBXTuJdWhkb53iUI
         CJYz+VrZ65hhvaklnWMBBPR2zLg5zLP2X825mVzXn82XtvR6Z/Ek1xZE0fR5f1s4hvc3
         EgRy06P/2ic5x3W7393r1cvc4eNC7iPe+NnuFgMcwgvugENv9xGNmiMnkE6itHJnlMi9
         WGHQ==
X-Gm-Message-State: APjAAAVlMoMKCBtLTAXPWiEbzKpbSmH1/1jppzgl94QUdxUxi+9AhYpj
        RMGML5Ati3rXIJqbEqO0nlfVbUfY
X-Google-Smtp-Source: APXvYqw/Lx/YxaORzJCKB74OjskQexdw6lmOnEtqKF2cGzIqRN9VZsE8gDodjoH8h/y4lpDS8vTpAw==
X-Received: by 2002:a17:902:bf07:: with SMTP id bi7mr31595426plb.87.1555116725223;
        Fri, 12 Apr 2019 17:52:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i24sm58250206pfo.85.2019.04.12.17.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 17:52:04 -0700 (PDT)
Subject: Re: [PATCH v2 00/21] Convert hwmon documentation to ReST
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
 <8514ff97-3167-3c89-3468-e247d14c5086@roeck-us.net>
 <20190412212541.0cde9452@coco.lan>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f1b5ebcd-bd8c-817f-1394-fd2742c5d8b3@roeck-us.net>
Date:   Fri, 12 Apr 2019 17:52:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412212541.0cde9452@coco.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/19 5:25 PM, Mauro Carvalho Chehab wrote:
> Em Fri, 12 Apr 2019 09:12:52 -0700
> Guenter Roeck <linux@roeck-us.net> escreveu:
> 
>> On 4/12/19 9:04 AM, Jonathan Corbet wrote:
>>> On Thu, 11 Apr 2019 14:07:31 -0700
>>> Guenter Roeck <linux@roeck-us.net> wrote:
>>>    
>>>>> While nobody does such split, IMHO, the best would be to keep the
>>>>> information outside Documentation/admin-guide. But hey! You're
>>>>> the Doc maintainer. If you prefer to move, I'm perfectly fine
>>>>> with that.
>>>>>       
>>>>
>>>> Same here, but please don't move the files which are kernel facing only.
>>>
>>> Well, let's step back and think about this.  Who is the audience for
>>> these documents?  That will tell us a lot about where they should really
>>> be.
>>>    
>>
>> Most of them are for users, some of them are for driver developers. A few
>> are for both, though that is generally not the intention (and one may argue
>> that driver internal documentation should be moved into the respective
>> driver source).
> 
> The big issue is really those files that contain both kernel internals
> and userspace stuff.
> 
> This is a common pattern. I just finishing converting a lot more
> documents to ReST and I found the same thing on almost all document
> directories I touched.
> 
>>> What I would prefer to avoid is the status quo where *everything* is in
>>> the top-level directory, and where documents are organized for the
>>> convenience of their maintainers rather than of their readers.  But
>>> sometimes I feel like I'm alone in that desire...:)
>>>    
>> I am fine with separating user pointing from kernel API/driver developer
>> guides, and I agree that it would make a lot of sense. As I said, please
>> just make sure that kernel facing files don't end up in the wrong directory.
> 
> I like the idea of splitting user faced documents from the rest, but
> this is not an easy task. On several cases, there are just a couple
> of paragraphs with things like sysfs entries in the middle of a big
> file with Kernel internals.
> 

Yes, I know. I don't think that cleanup is going to happen anytime soon.

Guenter

