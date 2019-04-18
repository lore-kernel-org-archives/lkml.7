Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3E2C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07897206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Fjc/jM4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389247AbfDRPBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:01:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42482 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388548AbfDRPBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:01:15 -0400
Received: by mail-ot1-f68.google.com with SMTP id 103so1941809otd.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=2Le3h0tZ8piv7ds5Md/NKWcj0xXcsOHpcKJMbbDJ6Dc=;
        b=Fjc/jM4NUogy2nD1DbKe9yeVNzDE9ZMp6ObtNwWd21VZP06CI1tl/ZCgNUQEQPgwal
         N61EcyhyhJT0P8dy13vnKWg6uiJQRybVwGG41eDN+nmQSoECOSYFqSUfhbGL8fVidn+b
         awyAMmHrpVhRPWe0LScK/Te8OZg5BGxYdA892DLnxpNOIj7t0dibn6aixKWCSf41YEh/
         zIm5B4OGO288MiVkiXQSNpwejh2H6k6XP1DCugVcLaLkmEqWEFQOrtDCtNb6LM1bUrW/
         7lgHpDY3ED3GgghLPB1cOcWzUQj+o6xE3s2UOOu7V6T4xIq4BPtN7MS50dS92T3LyvXY
         FevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=2Le3h0tZ8piv7ds5Md/NKWcj0xXcsOHpcKJMbbDJ6Dc=;
        b=H2yuYybsx+dzuWh48KDuKA2dyYKCz7DQlN3Tsk9SHloIJL8fkxYTrpn3fJH4DhUJ5S
         g6utci26ht+e5MfMvshOhKUXTNjiLMYBQK4ShS67O5/nXiga2qnDfNpLaOSZSwU2GzhT
         DOWSmlJV+PuZ/on0srlxYKILASwT6MM3jQ0ASW/biq3vvCu6xhqXx9fLbZDXEyGpZ9Lk
         US5pCMUWJRLeCHaiUlTtio+icLQQfJjqn3YrRCoezivNulkLI49R9n720NZLKTD6FXgY
         8SxKaTgPhzM+Y/Yby3bhV/QZ3c28fneD0PzH7S18NNc1a6cTU/az2WukNM55CwV87JHO
         p/MQ==
X-Gm-Message-State: APjAAAUSeKIgTB9flqVlaV4tVDG71Z0RL0ipAvtSnsXvZtcWA/sMTLg5
        DnJTm5LfvrvFJ1NMgq0eL04t3i9Xi4ExQA==
X-Google-Smtp-Source: APXvYqwPvZ2bwCDDFnRjPFLWXCy8fRQtKBwYjNw0B9sLmXc44aHslG6fgm0zUmsxt/cJzAIFizXBxg==
X-Received: by 2002:a9d:5f02:: with SMTP id f2mr61126046oti.271.1555599673297;
        Thu, 18 Apr 2019 08:01:13 -0700 (PDT)
Received: from [26.82.237.254] ([172.56.7.76])
        by smtp.gmail.com with ESMTPSA id c145sm1011912oig.0.2019.04.18.08.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 08:01:12 -0700 (PDT)
Date:   Thu, 18 Apr 2019 17:01:00 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190418142559.GA30069@redhat.com>
References: <20190418101841.4476-1-christian@brauner.io> <20190418101841.4476-5-christian@brauner.io> <20190418142559.GA30069@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/5] signal: support CLONE_PIDFD with pidfd_send_signal
To:     Oleg Nesterov <oleg@redhat.com>
CC:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com, luto@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        tglx@linutronix.de, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        joel@joelfernandes.org, dancol@google.com
From:   Christian Brauner <christian@brauner.io>
Message-ID: <EF6F0B39-1F4A-4A8F-9C64-FB3B1E804C83@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 18, 2019 4:26:00 PM GMT+02:00, Oleg Nesterov <oleg@redhat=2Ecom> w=
rote:
>On 04/18, Christian Brauner wrote:
>>
>> +static struct pid *pidfd_to_pid(const struct file *file)
>> +{
>> +	if (file->f_op =3D=3D &pidfd_fops)
>> +		return file->private_data;
>> +
>> +	return tgid_pidfd_to_pid(file);
>> +}
>
>the patch looks obviously fine to me, but I have an absolutely
>off-topic
>question=2E=2E=2E why tgid_pidfd_to_pid() has to check d_is_dir() ?

It doesn't have too; pure paranoia=2E

Christian
