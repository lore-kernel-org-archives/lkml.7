Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08FAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 15:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926E820830
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 15:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="FHEzZUbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbfIVPIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 11:08:01 -0400
Received: from mout.web.de ([212.227.17.12]:49963 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728211AbfIVPIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 11:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569164875;
        bh=/tLF8FNd+5kmvda8nqiASXRcjfYhY59Qr9QPeVtm7Yk=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=FHEzZUbE9BT1BiV2mklFHfH6Qc8q7n/mNtHv9AVksispNM514AAIpKURAoNeNMzzI
         gDWziUbOUgePIPndN8STFJyhSvN2eYvd6NEPp9fQq4uLGZODw9cG6N7PXhRLvTgp/Y
         BTpAeDfyS+uQ1bHVAf9K35ev1ihLeTvF7hCpTY8w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.8.78]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LZeVM-1hmdoV13ds-00lXHa; Sun, 22
 Sep 2019 17:07:55 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190815060014.2191-1-nishkadg.linux@gmail.com>
Subject: Re: [PATCH] ata: libahci_platform: Add of_node_put() before loop exit
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-ide@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ac53316a-7856-fdad-d982-5e80305be9d2@web.de>
Date:   Sun, 22 Sep 2019 17:07:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190815060014.2191-1-nishkadg.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QGWuVhgsrTwQtbMJvkcPYLOzikF4K9VLIABRRISa0iSUnkrbX8A
 jYzgnyKsK5saHIhzle0TXebDfDQQU7fNMNQJ05W9jdwm5cq+XKqnCI/I/klCUKVD2aRDcej
 Pa1DEoLNWCXHYMlaRNOZyVuePcrTpEimuiE4jjVGi6StcMzgYvgzLjJItUhDbjovczTT8y2
 j7LeW9AC6FbSJPe/hg6rQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HeexO2ggeQ0=:JxhmIxpQ1w+vlKGsBYZLRo
 Q+tmEHqkezEghj4ZlGv0z9gsqg9hp4WcwiVtJq3ZvjAPBG8lCZsgcPYrB1kRA0iU3nKjhvBZn
 wJT5lH7ZpHBp+9dTNeiEoNocc9eu/iCJh+k47gXhQA7wJ4oGEMEDcEvhoaVWvaZB5I9GhRUVF
 pPB8c8xPP6bo92F8+WZw4Sxf+V+dua4+j3yJcp8fyoIY2Mfpat1bVtojvcU8nofBDtwZ/wP+R
 Or1clhLAjDPwRM0SLT/xrX0WiGS8zje+JQ9bWwgGG+IOs1SV6Msyunxedp+tadwCv/169YWut
 xGr9liIwLdm3ziJlT649EabqQZaOKnjj+Y3T1MCCM40Qxc4YuSeZ75XriTeq1SIBy3b/b1iRl
 2Sam5E/a80Wy9MNYsWbF3bbWRwZ1ch71y3F187hSd07tEa3SxKmG0wNhIsIEGqQET/AbDpQ5l
 grj02wGyk8Wui/USWhAGfKkLDPKROUN0X5ss4m4FzHPulRGQy8zjvgtrR1TyN2wWvqAFWG37K
 z8snJmIhrgbSzYMrJqvmc9buR8TDjLh7kqy3Q0kI+/eA/9gtpKa2YetI+dYyJznhikAJK0PHD
 6LaAm6igZaLC1SprJ5r0wXyCXoEHykF22kvbX/0aQfIKrQnR0TJ4uizbq+MCpjxEPtS3wzqS7
 HP/7N0iGTLt+Zj+Bf7obr03YCxJGrtEPHwZroXsMWEYvVGQL7+8XpmNIqqOBnsE2lmAsaNUsq
 L2xWR/csPeF8Kqd3TDFG5/pB4/mmuyJ9g6kjcpVyo4LRo88gnaY0l+HCojKJghz1qnqJqM8Cl
 wGOjZbcdN9rxL3o64CxeusORn1uq1yF86qLzet9gP2yQxwtw+Ns7TUIajzMyRwIiom7hhiiqp
 O4iNFZG8HNzX53cslmnQm5uHlXBePlqlVDlEhuDQ1t/WHZya+VDXyHRzz6vhBZWQ9TS7GCrvc
 UrlHbzilDuNe0fRu9TMi8SxEp+mpsODBpd/6LocGblY8Rr5fJjNmjLk36dsbJdNOn+52o2+lw
 yrJARmtPrVBQdfkhODgor6+I6ycGo/Tpwe6QgFmCS5LXkjJLgqLzZ7g+sm7ziWDLaFl/tkN20
 FmnVmoklBHwqVN+2D8T3/BstT0yexLzDn5HJLaAGEUFtYZEG5n47vG4joMcXZReDBth5JqET4
 KbBpPhjKljDjKAO8WBqPewwbo8HqgfPeKzSnvfknjFeSYqDI4B/H1YRO305FETprVNz2TyViI
 rH7FzhcGbJr/bHVl+xTmwk/nI6ketenEbB7I5RvihBxU1630+PE53Kw93j7A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How do you think about to add the tag =E2=80=9CFixes=E2=80=9D for this sof=
tware correction?

Regards,
Markus
