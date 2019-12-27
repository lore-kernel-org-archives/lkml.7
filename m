Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F16C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 14:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D553420740
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 14:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="i7vfF3dB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfL0Oio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 09:38:44 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:35349 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfL0Oio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 09:38:44 -0500
Received: by mail-il1-f196.google.com with SMTP id g12so22606763ild.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 06:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lvrY2X8neN6Fjh9epCxv4wrPLNMXaY60K4+iw2mR7EM=;
        b=i7vfF3dBn33jGoHplLM77elKqkiESz4qNt1BaztIETFBTJ5whdWgvCQSIPH8PFHaj/
         8xVhhasADArasVg28n6s2Vc2qCBYZRJ1I3OPal7D5IAeg6MX1gGAC6HzVEGJQGPQL1FQ
         ge2D+F/t9Bc32VCU4LFWZ8uhHF1gAFZZzoBl1RtoQ2K6utroEUbYNGWEG8dx52CwHpfe
         Sky6mJ4/1BoPz1ifOt8hXx3P/V0jH36JBrI/l6JGugppwab+fOYcUd0l9M3KcTDcQltv
         AJWIcsCEKRWjRYqoEv8v4cSQ8SoF2PDWW+zl6GknlPKhMT7rRDPCuvGJNiYa8EoOQM1f
         FufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lvrY2X8neN6Fjh9epCxv4wrPLNMXaY60K4+iw2mR7EM=;
        b=hdlMH07iLLB2M+qwZ/jmgsuNRhVFA3oNorLKjdwgudqeGNijpxZmcU+7GNmJP7Xlz1
         4BYEa3MpEAmwDUEEePI7n8zDcsOTfqDV9bujgwjldmE9LuXL4MA2ohNWRKE+l6kk/+X8
         z7NTt0VKtvACTtHz9wwV3007Ez8rGfebH/1pERGmVu+5WDKXP7/ThqWNIlkqRXy44l+E
         ra1efsMySxjC2w66cFqgNeDbjpJ4+A7vl+WgAabptJRQEnwYC9AJC3P4TJWMP415JC/C
         8Tq0voy/KBX0o1Z3RQQmlMKalLtkMNqF1K783n1Y33GCNM5AnbWbxSJaQETB0mBxZRZH
         jkfQ==
X-Gm-Message-State: APjAAAWS9FdPszzwSJHw/39yvDAowZKnRwpDJw2HWO0WHAnbM6CXXfUS
        wBtGBEQe/l1/3X9ieXSxHFAqiA==
X-Google-Smtp-Source: APXvYqwBb0XH27u7cvcETb0bOEj7RsGLqt4zN5lTv5NPgihNjummTVkvK9KeDtfwWkrgBxpZxIdHeg==
X-Received: by 2002:a92:5d03:: with SMTP id r3mr41644046ilb.278.1577457522670;
        Fri, 27 Dec 2019 06:38:42 -0800 (PST)
Received: from cisco ([2601:282:902:b340:f166:b50c:bba2:408])
        by smtp.gmail.com with ESMTPSA id 81sm13304729ilx.40.2019.12.27.06.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 06:38:42 -0800 (PST)
Date:   Fri, 27 Dec 2019 07:38:39 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] seccomp: Check flags on seccomp_notif is unset
Message-ID: <20191227143839.GB15663@cisco>
References: <20191225214530.GA27780@ircssh-2.c.rugged-nimbus-611.internal>
 <20191226115245.usf7z5dkui7ndp4w@wittgenstein>
 <20191226143229.sbopynwut2hhsiwn@yavin.dot.cyphar.com>
 <57C06925-0CC6-4251-AD57-8FF1BC28F049@ubuntu.com>
 <20191227022446.37e64ag4uaqms2w4@yavin.dot.cyphar.com>
 <20191227023131.klnobtlfgeqcmvbb@yavin.dot.cyphar.com>
 <20191227114725.xsacnaoaaxdv6yg3@wittgenstein>
 <CAMp4zn8iMsRvDoDtrotfnEm2_UUULH9VRiR6q9u8CS4qham2Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMp4zn8iMsRvDoDtrotfnEm2_UUULH9VRiR6q9u8CS4qham2Eg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 09:22:20AM -0500, Sargun Dhillon wrote:
> Just doing a simple copy_from_user, and for now, calling memchr_inv
> on the whole thing. We can drop the memset, and just leave a note to
> indicate that if unpadded fields are introduced in the future, this structure
> must be manually zeroed out. Although, this might be laying a trap for
> ourselves.

Yes, please keep the memset().

Tycho
