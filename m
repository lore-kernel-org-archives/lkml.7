Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8840C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B00213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NggtkKdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfCXRdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:33:43 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:44031 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfCXRdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:33:42 -0400
Received: by mail-lf1-f44.google.com with SMTP id g7so4412277lfh.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kTyb/qPGOj4Gv5eOOTNPuusPHYJt3q5qrdmr1EaRpPw=;
        b=NggtkKdHAlqaMPgB/GB786PiEaWGymQfBkOsmfE9zJD8+qLGgvRx/4KYdY5acq5ULT
         FNzT0dw3ERNeVKiFKDSxmYI5Nb9pV/2bb/anWgzlTeNEzsBxs/rBCloRJQKBvpMCOvBV
         CjbJ52OiTLJM+n3xwfKspkPIRTGuCcZnUGfjbB3sMo29ni1ut4OFF+CNJV+igLgIVB99
         sS86O/q2unwCU2gsTDZ65I0oOW2ug9SWs+lANg7nbO4v+Lp3Ck8NnaDn03su1Slk220d
         QM2zXgTK9+BAfbpjHshsVm9XPoCt2fCzo7x7aVVDh5Q2qFeFYuB2tAwmcQ6kSlZkXcmw
         AobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kTyb/qPGOj4Gv5eOOTNPuusPHYJt3q5qrdmr1EaRpPw=;
        b=Kycvv72Eu7fjEhXlc0cKb6+WZUITPCJIo4zBIPxMsWYUE9upVWGJD6hjZzffOUpfvk
         6VtRBtdoUqdGzEvrGeVwNOqVJMGFQ7sJZ7deRhriauaI6IJRfdMhRvBoIolpYHBAnASD
         kuT78L1qrvs2SXZQIPMxku1bJB7gfln1iHZpbgdvqYjLnayEcJgSqPI+RxfILmYKRQqj
         RcqRbUr7UDlHps5nNQUqkMSJOCz/wI7P2xpo7xyXQMEcGChbGG7j35/FRxfNoOwVBAP0
         Pz+pvTz0xlE9lh0smmHYSkDT8xvMEoKiFLOEC1LhPWczfW6uEVs1WWwkre7PG8abMGnS
         Eryg==
X-Gm-Message-State: APjAAAUt2uhaRMf3Wc6tuUxYkN9O8dtLSP8Me5L9g+D3ppXgZMEIqbSk
        MAfMRXqfK+VavPTHQRqYZ0g=
X-Google-Smtp-Source: APXvYqwIRPeRKkb5h6l0/CzgxoEV7a99qDhYiRwdt+A/kR6N98mlN/t1J9/zxJcpFPZC38QjaCtQiA==
X-Received: by 2002:ac2:4192:: with SMTP id z18mr10066837lfh.39.1553448820744;
        Sun, 24 Mar 2019 10:33:40 -0700 (PDT)
Received: from apple-mbp.net (85-76-48-99-nat.elisa-mobile.fi. [85.76.48.99])
        by smtp.gmail.com with ESMTPSA id t81sm2942620lff.21.2019.03.24.10.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 10:33:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: UNIX(TM) with D2LD0s UX 
From:   SHANNAN Syrjala <unixlezshannan@gmail.com>
In-Reply-To: <188CC042-FD8D-4512-BBB8-5538A3D4F8C0@gmail.com>
Date:   Sun, 24 Mar 2019 19:33:19 +0200
Cc:     Shannan Syrjala <unixlezshannan@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <56C26246-D400-49C0-BDE1-12DF92EA0009@gmail.com>
References: <188CC042-FD8D-4512-BBB8-5538A3D4F8C0@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux dev <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

Here are my contact information. Feel free to check my pages having the =
latest information at

https://www.facebook.com/shannansyrjala
https://www.linkedin.com/in/shannansyrjala
https://www.instagram.com/shannansyrjala

> On 24 Mar 2019, at 18:53, SHANNAN Syrjala <unixlezshannan@gmail.com> =
wrote:
>=20
> Dear all,
>=20
> Heh, here's a funny script with "my first java app=E2=80=9D script =
kiddie attitude ;) This should be the last crap then we are done! I=E2=80=99=
ll promise something if it helps me: =E2=80=9CREALLY SOON NOW!=E2=80=9D =
;) ;) ;) ;)
>=20
> Luckily I have had Mint because of our UNIX(TM) not being available =
down here for me for security reasons, looking forward to meet that. And =
of course, thank you all for the kernel for UNIX(TM) with D2LD0s UX =
already! Really soon now the World OS and Lez OS will run on top of =
that!!! :D :D :D :D=20
>=20
> https://pastebin.com/BqyKrJdF
>=20
> https://pastebin.com/2vTZiHce
>=20
>=20

