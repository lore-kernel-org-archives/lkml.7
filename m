Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BEFC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 22:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF0D2081B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 22:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSkK+t1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfI1W3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 18:29:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45121 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbfI1W3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 18:29:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id u12so2409103pls.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 15:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=AEZIJNzLPkvsFCAzQm/Iaj2JvjR7Pra3pBs/P444LIA=;
        b=BSkK+t1rem246jzTlalFkAqga0guUSSHEtLeWsO53LpfnYU8auIx7CY0mBtnOPsJj4
         j2qQoHhjaY0tNJLUvqL+kp8MCT/ZALu+qi0chkb23g8V6uL2puNyFG3Bd5vRDoeE9jNW
         7HjCZtbQcPuhtKZor75t//6X0o4tgcXfSSp7MJJZnV9SFTdhAWpP//cJEN28G9Qq8A4c
         f51FjRPp809BtL29997NaessI83my1iTO59aic4Y5eOcErQLmADUGLZbQmDXvuZNQleK
         vqSsfkaZWdlTdRQ/QwUQxIoelmJaxmsafhVeqHg5K0T3e5YfEtX/rlJs5aWnji54E8Us
         5orA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=AEZIJNzLPkvsFCAzQm/Iaj2JvjR7Pra3pBs/P444LIA=;
        b=ax29ThzCMabHdU544y2XXQ6dlBJsoBjnxDb3gDJwYTI391DWPL3ia4u6qW2gyc7G2z
         v7Sc51jD2FvnFPCwVkmiY45RS+VIlOveVENxIXdSLHjeNqhPWyX85XrGXjaVOb19HJM2
         BWcWft1XTM4T9eHOLTvLQTAnjn4apuqkbNhDi7+RxFqK5hyNmonxvimtVdpiWT4vtzM3
         KLKVcMpAYU58o6fkfxAC0DBjbbyqFGkCG/c0ciALyqJ6ZftIiCWp88XSiZC/9CwRu725
         46L+UozT350f7X56xZHOeYjRRDLknlv3cfSjGvkPY4131jXRutxHq5eF/F5NiJJx9GdV
         ba8w==
X-Gm-Message-State: APjAAAU6JXRLLavYWKWiNu/tL0EGyVPSYl9r2PDCwPq0Qm9+Ou4mwatp
        ggKZVNndwXPWTNH7eHAuNEj0FJaq
X-Google-Smtp-Source: APXvYqzGYJWDyRmqlR5Cog13s33yU172iG9Cc4yeeElgqsj8+wAdrSKTn883Cw79/gd/0DzEJRM8Hw==
X-Received: by 2002:a17:902:144:: with SMTP id 62mr12562357plb.70.1569709786041;
        Sat, 28 Sep 2019 15:29:46 -0700 (PDT)
Received: from alun-evanss-mbpr.local ([2001:5a8:4:3d80:2137:a395:5c87:9605])
        by smtp.gmail.com with ESMTPSA id 19sm8666721pjd.23.2019.09.28.15.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 15:29:45 -0700 (PDT)
From:   Alun Evans <alun@badgerous.net>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 05/27] containers: Open a socket inside a container
References: <m2o8z7t2w5.fsf@badgerous.net>
        <871rw1yey8.fsf@x220.int.ebiederm.org>
Date:   Sat, 28 Sep 2019 15:29:44 -0700
In-Reply-To: <871rw1yey8.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 27 Sep 2019 09:46:39 -0500")
Message-ID: <m2d0fkt5pj.fsf@badgerous.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri 27 Sep '19 at 07:46 ebiederm@xmission.com (Eric W. Biederman) wrote:
>=20
> Alun Evans <alun@badgerous.net> writes:
>
>> Hi Eric,
>>
>>
>> On Tue, 19 Feb 2019, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>>
>>> David Howells <dhowells@redhat.com> writes:
>>>
>>> > Provide a system call to open a socket inside of a container, using t=
hat
>>> > container's network namespace.  This allows netlink to be used to man=
age
>>> > the container.
>>> >
>>> > 	fd =3D container_socket(int container_fd,
>>> > 			      int domain, int type, int protocol);
>>> >
>>>
>>> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>>
>>> Use a namespace file descriptor if you need this.  So far we have not
>>> added this system call as it is just a performance optimization.  And it
>>> has been too niche to matter.
>>>
>>> If this that has changed we can add this separately from everything else
>>> you are doing here.
>>
>> I think I've found the niche.
>>
>>
>> I'm trying to use network namespaces from Go.
>
> Yes. Go sucks for this.

Haha... Neither confirm nor deny.

>> Since setns is thread
>> specific, I'm forced to use this pattern:
>>
>>     runtime.LockOSThread()
>>     defer runtime.UnlockOSThread()
>>     =E2=80=A6
>>     err =3D netns.Set(newns)
>>
>>
>> This is only safe recently:
>> https://github.com/vishvananda/netns/issues/17#issuecomment-367325770
>>
>> - but is still less than ideal performance wise, as it locks out other
>>   socket operations.
>>
>> The socketat() / socketns() would be ideal:
>>
>>   https://lwn.net/Articles/406684/
>>   https://lwn.net/Articles/407495/
>>   https://lkml.org/lkml/2011/10/3/220
>>
>>
>> One thing that is interesting, the LockOSThread works pretty well for
>> receiving, since I can wrap it around the socket()/bind()/listen() at
>> startup. Then accept() can run outside of the lock.
>>
>> It's creating new outbound tcp connections via socket()/connect() pairs
>> that is the issue.
>
> As I understand it you should be able to write socketat in go something l=
ike:
>
>         runtime.LockOSThread()
>         err =3D netns.Set(newns);
>         fd =3D socket(...);
>         err =3D netns.Set(defaultns);
>         runtime.UnlockOSThread()

Yeah, this is currently what I'm having to do. It's painful because due
to the Go runtime model of a single OS netpoller thread, locking the OS
thread to the current goroutine blocks out the other goroutines doing
network I/O.

> I have no real objections to a kernel system call doing that.  It has
> just never risen to the level where it was necessary to optimize
> userspace yet.

Would you be able to accept the patch from this thread with the
container API?

    fd =3D container_socket(int container_fd,
                          int domain, int type, int protocol);

I think that seems more coherent with the rest of the container world
than a follow up of https://lkml.org/lkml/2011/10/3/220 :

    int socketns(int namespace, int domain, int type, int protocol)


I could also put some up if required.


A.


--=20
Alun Evans.
