Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE985C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 14:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B2F21850
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 14:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="JuXWBELf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfJLORV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 10:17:21 -0400
Received: from mout.web.de ([212.227.15.4]:59891 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfJLORU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 10:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570889825;
        bh=43EzPAmHAZ0Dtzuyzozgs7lVBnutIVoFvCod4h9g4DI=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=JuXWBELfqZxYq75SyY4FA8T9ZwrMndK75bPMQcAWvIiVovaNLEY3qfi9wWE1YIsi3
         COkiHdDk+6lQbkjFnoD1w2xyWAnDEkViFEYUw1T6cvt5mv0k5AAn1JGsvQPHKFnSkA
         PfzJMbo8EQGfk/z91WJ6nxyIcboOGrask02ShAqI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.155.250]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MBTXi-1iC7C31qgo-00AYYg; Sat, 12
 Oct 2019 16:17:05 +0200
To:     linux-clk@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: clk: samsung: Checking a kmemdup() call in
 _samsung_clk_register_pll()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
Message-ID: <7933ce8f-ca1b-6ed8-14b9-59679130dc47@web.de>
Date:   Sat, 12 Oct 2019 16:17:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X1F7tXo59Mds4Q/yyqvj3QxLex00lBUKxtlaIFwh25KSANcGpxn
 Y3LGyt1zzJBnC+26feUrO8TcJmyExJsYS0Cb8AP3uiRCJtDEDF+gLMUpRHgjJ0KYCJjr6I5
 2/UikgLihOpi/S0oaiMJm/7foukO0sGsvC6GDg2oPpR/APCmj3Qp9CecOCa9fj6NuoNh7ks
 rZX6DnEGzftbYkvyjtxsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0WcCnuuFAB4=:frsiWahP/7pzcJsiZW06Vo
 hYPZDrCKKHY31HWE5noTfSQVE7Oe05KEq5PZTmwXo6CzkNgFIAvjBXl5PGgzYuu6rAlKAYBfj
 T1wWp41vmG7oSvYLgRq/pe5Cz1BTTK+vUPelAZ2erhJj3KOSmuaYrWa3aEtpElhqJoraHAdte
 vWEBX/EWQeHWbDz70nJx2YYAheiEDTECTJbA3IFbD2tXXOL3hqJmLy8qOhxY3vi7xRTuh91Rd
 V9v00l1UElDRSc2RHHxdXIDSFi9z2i/Jhu43noK0U7vbRfE9SiDoXjLp+qyDU3/1gYYUiyAyL
 QTPhqU/4ZgVnxHvj02cEdz45jrh01Wt00LipU147OSwDzHwNsxI+lobj/5eqnZjglS207HcCO
 Tehi/tLcQgS92kEmECpdnu83kWrzV54vkZupkXRei9RPUDWnf//aeDD2+zoeNBEiXOxGoLXFm
 LERudq0aW8aKkfomA6Nzn2HSBUR4x0zPzAB1eDO5/zap3wjEyaN9ErF9xdHd/mOb2uDGPz4Tj
 +sKlUKV1fHud+0soy567VkMZYPvp16xV5e9QQVoFqN2LcFrofyFXLNnxlaWw124q6i5kKn72l
 OxjvnJkMVFPNaKbtGkr/HTjvKha5h2SRxDmqJLhGtboxqACb32W56V5ZsPdCbw/VsHDcwR6M1
 3HFJTHJowMk5BKy5Gj8w5WsKMUqf6WV2YYlLMIukNQiV2IGR7c9DYjqlA/2JbGI4rsv03GREz
 xpMh5Jkd2BxsYwmbQxVC3JPMNABxMelclfBGJHFlRX+DoostiQ3f+1qZVobHH1UtasrVRi20I
 RluqxKJY7tPR6B+xbyrbJ7qjtwx4r8rx47t1azirbtJI+ppX/eWx9UYLBaPc4lOXtHcmNDMqE
 veU8OCDm3iLg8ciabdRuPXtcdCI4ptnJVDOxSIVii0x9ersnJrYdVatdHrwH6GFauyqBjmqD4
 FRwkY8EtYdaP4zYnN3Nuq9DpsJgoOGpJ/c+CImTLOk1A0nNwMoHINSubcbj75OxYYIMPkERn0
 Byfc/DjXZDrshFTPnQ46BG1prucCcGo9p0FMjluHHhKdrbhYyserrT4noOBO2pcU8yWOnssR6
 oozTZqfXuWAT649VELrR1gtbYJVL8PSrsVCEXe/5/T7zALMWwGemMI/9ctkB9dgNU2oMvs64J
 aH90GFF33NjzXYsd11OyB4Arm/hc8nSM7c8n75ElHk5kvMAnHZr52Q2276kqOaNi4Cmxi7aqx
 sNnkkRjfP0g17giEQ80VU3qr2VkQnWaQN5C967NOBdMmgY50o0fo9IWGBJFhp08bpH20rymcI
 3hnc7ZGbfj5KC0rDXM81lIp/n9GmCWlmhEjhRX//H3XjfgMtpHHRlZ3MlhqfhiVJZ0iT9Z1z2
 vGH+mB3E6kSA7515HhDh/5giWJpk+t6dj3Ozl2/R3hrzIyF4m6pfipakAiH8JTVanrSbhrG2a
 SheLY8n7/ft8GPJdmh1fZA9FhOSQJdPhgbn+aAyowvVugbQb1J3We4pNNfpRZ+uPKriOCSkC+
 5SA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried another script for the semantic patch language out.
This source code analysis approach points out that the implementation
of the function =E2=80=9C_samsung_clk_register_pll=E2=80=9D contains also =
a call
of the function =E2=80=9Ckmemdup=E2=80=9D.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/clk/samsung/clk-pll.c?id=3D1c0cc5f1ae5ee5a6913704c0d75a6e99604ee30a#=
n1275
https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/clk/samsung/clk-p=
ll.c#L1275

* Do you find the usage of the format string =E2=80=9C%s: could not alloca=
te
  rate table for %s\n=E2=80=9D still appropriate at this place?

* Is there a need to adjust the error handling here?

Regards,
Markus
