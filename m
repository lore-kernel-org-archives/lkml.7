Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A728EC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C05206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="TSvjsmsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbfJKNAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:00:36 -0400
Received: from mout.web.de ([212.227.17.11]:51915 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728406AbfJKNAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570798816;
        bh=NgL6zGAAGZZ/ba87NQfyScnMOpeIlLDG6n+WCdQWllw=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=TSvjsmsJ9/zaJgZBR+FGOQVMJwWrPE1bft7Xr5MP80M36XTh/EWnXk1RVLQca3kBM
         NGzbqm8AlWLwj35RBJ2N6spXbhL/xIVbfTfNzEoALZNxX+g91E0YAC72LrLOWRmD8Q
         SJpFZu6VufBZ66FBFQk0cziGIgEC/0oiwXfFWt9E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.164.92]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8zOD-1iDdju3dVd-00CQTF; Fri, 11
 Oct 2019 15:00:16 +0200
Cc:     linux-kernel@vger.kernel.org
References: <20190325212523.11799-1-pakki001@umn.edu>
Subject: Re: [v3] thunderbolt: Fix to check the return value of kmemdup
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Aditya Pakki <pakki001@umn.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Kangjie Lu <kjlu@umn.edu>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        kernel-janitors@vger.kernel.org
Message-ID: <f2960ada-7e06-33d1-1533-78989a3e1d2a@web.de>
Date:   Fri, 11 Oct 2019 15:00:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190325212523.11799-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Qs05se5kp5/XXW7uyPGar13wVW2Imrz9QjdzEBUDILjZUhPyuH
 NEI2s/vW+JwNK7rqE8MVis1C/CnewOR7g8ANndHeKLQWaDF/Z7YGcZhVTpwurZ2T9uGd3M4
 hAZp58RG87bswmkyObIW09bSmQizA7dkYSsUAPVN5DXmT2zACHMWBRmsvZfRGZewK2+wrDu
 1FYgQCf0t1J9GbtO/IN/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FyHqf6r6FPA=:U79YlzLpl3+o0bFhWP7G3Y
 uHTNDuOMGv0NB/LPilvNQEeJP09cby2o0dLxqnsR0htX+Nt4UU34QFYw2SWjC6iaxPZy5Ic8B
 J0jxbvrN3LGhzzT60lp5gW6gVsgekJYS/E3z50vaVnAi8hb4YVEPtOyTUJvviQtcJyzCZOQxt
 X/9RXj6XKi7tC7Uw/OQxkB8qVmYxMp1wHN2Ht1qRUayy8Q4yHM2wPCUPaNTbBT+/bAEc7yid7
 V1KV4KvOxLvAcY8bR0Kk4ikBkGrXzqPiFKu7oLeg+2VlVnqpr9FRbDouUWrfBJwbfQCG3/faK
 JHF1bo8Z/rnzlgSXQgL/gu0Ybj6M4yoH4eEPu6S6l5GcBKiyDB0LOO2gzuPXZ0+P7dIpp1S2S
 7cFvSfQ4oxWf0TJrOYStoj4eFvFtIsPqWaV1tMqsi+wXzKCTk8AkeNIRcxkc1R+7AOontofzj
 ro9OeJea24VJF5fGYX5RiPTilxiXB91KDdJrSkeMEN3fwZxwSxWrkAKuY8h2cw6AltA3AIilt
 Bafr7uggpzjzCqA5rYHn33y8bBD2nVC8pv2KQWx1L/yWP9gsK+AE1W1MuzJhWrBe43uCF3xt9
 wsSzVy/TSGlug8uJWTma64GzOfXxZKUVYwFieIZx9uIE1C79IpfXTyCdIa2TcDmzRn6l9ekV5
 8hPCgWiIUWgCNdRJ7jdI07WkOyhYSFGyB4Zelfe4fAlvKSiUsjMzkBbLAbKqHCPy/zSIF1rgR
 iol8mRFJlRxhmyEOFSwmMbVtDbgkMnsjSvLeTNbcSqQKA5GFQa0o+ecBxGKQLLs3pYQpJU+Jh
 G4KYlSKUg0rbI+fkYG1Eb9MnVnPVJB5z8xSHdBMYji451qSbpMxvO5N3CQHpOZojVkn1uh+9a
 7PaQpgAvNhxXFtHGmAwyOACMFt+WSzWobiChhs45/LX3XodE4wWFJxrvKR1XTUV1oW+P4fpED
 OOaThMF7iS3ho3VU1tAuHGy4zbvX6pbVZQqyu9Gac7osNxD6HYyppFIiR6cdkv0mUy0w8xX9o
 sg5GRPMbHJcUt1Rik57pVdh3gZ7cq9C+dc53voYtglncvjqKsQYHxPBvcPmODUW7p74p++BnM
 NDOsf+GU0BELcpgA+FWr61V40ox7fuAVmo1Er/YKSFsfNh9hx3KaOaLTZeeNoIvef/o4VRDw+
 kHljeDs5rfoSL7usLapCrUMczZ2+2xIaPpa02UeOT4l6JuDAJ594ejZyytIG4k5ZHGj/DMCQ1
 keBtnpheIIBcZBTsdrYXViUgbNXoOINVhSWULDLIDe+1bdyJe+tBiqSAPH0E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> uuid in add_switch is allocted via kmemdup which can fail.

I have tried another script for the semantic patch language out.
This source code analysis approach points out that the implementation
of the function =E2=80=9Cicm_handle_event=E2=80=9D contains still an unche=
cked call
of the function =E2=80=9Ckmemdup=E2=80=9D.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/thunderbolt/icm.c?id=3D3cdb9446a117d5d63af823bde6fe6babc312e77b#n162=
7
https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/thunderbolt/icm.c=
#L1627

How do you think about to improve it?

Regards,
Markus
