Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C29C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAF82073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="QoeFvxk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbfDQRkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:40:36 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36301 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbfDQRkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:40:35 -0400
Received: by mail-it1-f196.google.com with SMTP id y10so5778220itc.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 10:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=uVrb5dweB2C8mXvi3q1l0v5rIi877toRasgD0R+ONMw=;
        b=QoeFvxk2fEJ0TpTcXOEIliUb9HRHH2C83+Vz0jMkBvDNtVIOIBAM+D3zQPCfHcpu12
         WsZeBN3z7JUSQjAxXuViNScX+Facde+gFapRMm9IFSIINU9umjpzAwSvHxxP081Tiinp
         5++D9TV0PR+s/pcMcN6QqxehzTUi0RFWRSZIf9xFovOotA7kg9R/EKmxZWFgK/MpERAs
         +3jXg271ntys6G7JGYQ4DwJb7PNT6sAMh4MwxhL5Z+cJIoiMPTnrdgAiC/dhQsAB+d5L
         +iblyq2XsN8BD9gFrKfLvysaIlJa7OhsDrjDoQsuw4igps+YwbZV6Q/ZfKwVLpDrjWv0
         PhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=uVrb5dweB2C8mXvi3q1l0v5rIi877toRasgD0R+ONMw=;
        b=nU8I77K1ibPIofeOVo3nBSu0heZhpul8ayoQGOPsyDV51Tqxy6eWmNc4CQro+mkVn2
         cG/Vi225Mhi2ulzADwi76Suh0fFV4tyYUkAV0wit9sW8gOlCkOYG1pEvKqN92I46PH/6
         osYj6I+0kLCRWB3ubS3XHrDRCvxMKjlRMB1FmEKu4NKeJ8rJq3KXevCC9ipzWavU9OZJ
         cuaVlGNa7cFArGX68SQ1cVHHS5bqwNoeggP0UQ8GQXYlc7lS8hBZORTry13+0lsSLHXU
         wChcl/ZRUoiqaeV3pjm0d8U8iWi+c2VlEhoZtQliBd07vvbtLyjJqHqOFXb8KOrRQsOn
         b/kw==
X-Gm-Message-State: APjAAAW8bZ38662Gjw4hw7NMnVHnXBT1N4j4/RF1sQrTAKO9VOhGWqSz
        wJJGPl30EsYMquCL++FHv034CQ==
X-Google-Smtp-Source: APXvYqwsoNTYwbts1PjPRYKI4T8hAdJH0qSTMs3ZHUQiaM7ubgVHnBln1JDNP8jxdLqf+PEWJmct8g==
X-Received: by 2002:a24:1908:: with SMTP id b8mr35308565itb.136.1555522834572;
        Wed, 17 Apr 2019 10:40:34 -0700 (PDT)
Received: from [26.66.231.223] ([208.54.80.227])
        by smtp.gmail.com with ESMTPSA id t142sm1557379ita.38.2019.04.17.10.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:40:33 -0700 (PDT)
Date:   Wed, 17 Apr 2019 17:36:32 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190417152055.GJ32622@redhat.com>
References: <20190416170233.10208-1-christian@brauner.io> <20190416170233.10208-4-christian@brauner.io> <20190417140106.GG32622@redhat.com> <20190417141144.k2kmg7hd7pdpywyw@brauner.io> <20190417152055.GJ32622@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 3/4] signal: support CLONE_PIDFD with pidfd_send_signal
To:     Oleg Nesterov <oleg@redhat.com>
CC:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com, luto@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        tglx@linutronix.de, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        joel@joelfernandes.org, dancol@google.com
From:   Christian Brauner <christian@brauner.io>
Message-ID: <B0F3DFB1-B9B5-478C-89BB-75CBC7719D3B@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 17, 2019 5:20:55 PM GMT+02:00, Oleg Nesterov <oleg@redhat=2Ecom> w=
rote:
>On 04/17, Christian Brauner wrote:
>>
>> On Wed, Apr 17, 2019 at 04:01:06PM +0200, Oleg Nesterov wrote:
>> > On 04/16, Christian Brauner wrote:
>> > >
>> > > @@ -3581,12 +3588,12 @@ SYSCALL_DEFINE4(pidfd_send_signal, int,
>pidfd, int, sig,
>> > >  	if (flags)
>> > >  		return -EINVAL;
>> > >
>> > > -	f =3D fdget_raw(pidfd);
>> > > +	f =3D fdget(pidfd);
>> >
>> > could you explain this change?
>> >
>> > I am just curious, I don't understand why should we disallow O_PATH
>and how
>> > this connects to this patch=2E
>>
>> Sending a signal through a pidfd is considered to be on a par with a
>> "write" to that pidfd=2E
>
>OK, but how this connects to "support pidfds" ?
>
>> Additionally, we use the fops associated with the fd to detect
>whether
>> it is actually a pidfd or not=2E This is not possible with O_PATH since
>> f_ops will be set to dummy fops=2E
>
>indeed=2E=2E=2E I didn't know this, thanks!
>
>But this means that pidfd_send_signal() will return -EBADF with or
>without
>this change; pidfd_to_pid() will return -EBADF even if fdget_raw()
>suceeds,
>right?
>
>To clarify, I am not arguing=2E I am trying to understand why exactly do
>we
>need this s/fdget_raw/fdget/ change and, why it doesn't come as a
>separate
>patch=2E Can you add a note into the changelog?

I should split this into a separate patch indeed=2E
Let me do that for v2=2E

Christian

