Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C47C04AB4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 00:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EBC20881
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 00:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kPwO7Xjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfEMAXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 20:23:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40109 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbfEMAXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 20:23:39 -0400
Received: from [IPv6:2601:646:8680:2bb1:80c8:8cb8:dd71:1e2e] ([IPv6:2601:646:8680:2bb1:80c8:8cb8:dd71:1e2e])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x4D0NN5I3267505
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 12 May 2019 17:23:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x4D0NN5I3267505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557707005;
        bh=/7GRxEbhkfOEmbDinh0dyNPUVrqyoxdHEHoAVKW9xGE=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=kPwO7Xjx9BF5tTOaClmwEtsRb+cB/Qfn980At88CURskK8z+agDkl+UsO9O4ryMsd
         OBdU66w7Nu4rwOOjD7pMDga/6lwrt2yQN3mb25om+GLtwg6tTNtOvewt8HCJemkASp
         XWOoQYwiKM2iSYr7AzBg+RDd8PBzDng4amcENtQdGAn2Hxe/fyLw6x+v9nKHECi+zn
         ykrD1rmKo0b/XkiRUvTWIfZfvtmnJ6k7G0pWj+4ZoPChvfTuDErATGeJEyRRkYjfPP
         LNoVp3Fl+v6qEOGQYa46kHS1Ul5TdBpUjuJZ0gXI5Fd4cppa/b7r1ncELkcbo5E4xt
         dP6AatRgj0Z1A==
Date:   Sun, 12 May 2019 17:23:16 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190512153105.GA25254@light.dominikbrodowski.net>
References: <20190512153105.GA25254@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial ram disk
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Mimi Zohar <zohar@linux.ibm.com>
CC:     Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, arnd@arndb.de,
        rob@landley.net, james.w.mcmechan@gmail.com
From:   hpa@zytor.com
Message-ID: <0D08BE40-475A-47AB-A3CE-B8EC4C4357D9@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 12, 2019 8:31:05 AM PDT, Dominik Brodowski <linux@dominikbrodowski=
=2Enet> wrote:
>On Sun, May 12, 2019 at 03:18:16AM -0700, hpa@zytor=2Ecom wrote:
>> > Couldn't this parsing of the =2Exattr-list file and the setting of
>the xattrs
>> > be done equivalently by the initramfs' /init? Why is kernel
>involvement
>> > actually required here?
>>=20
>> There are a lot of things that could/should be done that way=2E=2E=2E
>
>Indeed=2E=2E=2E so why not try to avoid adding more such "things", and
>keeping
>them in userspace (or in a fork_usermode_blob)?
>
>
>On Sun, May 12, 2019 at 08:52:47AM -0400, Mimi Zohar wrote:
>> It's too late=2E  The /init itself should be signed and verified=2E
>
>Could you elaborate a bit more about the threat model, and why
>deferring
>this to the initramfs is too late?
>
>Thanks,
>	Dominik

I tried over 10 years ago to make exactly that happen=2E=2E=2E it was call=
ed the klibc project=2E Linus turned it down because he felt that it didn't=
 provide enough immediate benefit to justify the complexity, which of cours=
e creates the thousand-cuts problem: there will never be *one single* event=
 that *by itself* justifies the transition=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
