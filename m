Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545D4C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F60C21473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG/ioZxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbfEMPKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:10:45 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36857 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfEMPKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:10:43 -0400
Received: by mail-yw1-f66.google.com with SMTP id q185so11274208ywe.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=/ALChiOKnMbi5IPfVvBTTx9Afx2HTWGWhcKipkGBRc4=;
        b=DG/ioZxRbc7Psl2Rwn2D9Ljvkt168cPnUdDyG2qr7woivVllgieIszsYuhKHWnIO4G
         GCqPQrI+BpWFdHAIH/kt7DXJRxvMVOtgd6LJ9tBxFUToeqJVwyuR+mQ7tOzX4yuxxNYs
         kk0CojDahTsS606dhWKKYke1XmI4IGjFmUjeNW4I5/wyV4JuNPDsewD1h2zNTq5rUiqS
         I00jbiO0/5kw/mNW/eTXXm0uf6hHgE1V9ZRlMSzPVOJB/bwToMaHWbMPDinrfnWmzdEv
         lSsVsECDhKyg6U6YZ9K/4TP4A8EvTZ5mi0jZOMHIS2HaSMYNOmETxYOoQZI2uAYidRrj
         urig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=/ALChiOKnMbi5IPfVvBTTx9Afx2HTWGWhcKipkGBRc4=;
        b=saa4fqiVTtll0TSk0Ax5h0I1AgAoLWumtZr6yKhPTJcuI5CAKzHpZzwrvJPvb9Ij50
         wMKOevrpT497fOBIpiUnFaFo8dxe/MtBzFceLALnd/qY2vsVspg7VPjqkdJrbJ1BjWPP
         eiroH7WfCrVRCJ3HSxtu5AZ3fVdRNpYIdUIySst61joHbZOnSEICW6pscP3lL+b6vxdh
         k57Xliu/VdVYFEs8sryhETH515QuDia78DiSucJNzMRH1VJcRYNBeOFzfN7vtCpwmd1G
         pTbm+28SO7wsRiF/jWf9PxHfbdgk/abJLifdAhwrxv/cBiGO4/6d/pQnhihtYZNQWILO
         YLUg==
X-Gm-Message-State: APjAAAVBSJ6cv1yPuL2NzKfoW0xG4jbKxVrZ2ldZGzuTiMUJI6v8AjVK
        Yikylp/he/7G1xDR3DnpaJ5/xGArHc3+Rv7Gd10=
X-Received: by 2002:a81:9284:: with SMTP id j126mt12287877ywg.445.1557760243034;
 Mon, 13 May 2019 08:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190502074519.61272b42@canb.auug.org.au> <a645ff18-4c55-6b4c-0913-5b397ab83e03@gmx.de>
 <CA+QBN9A4PhPZ36otsk0TRaO9KKnKL=hfnskfFJGQJEbtb3=i=Q@mail.gmail.com>
In-Reply-To: <CA+QBN9A4PhPZ36otsk0TRaO9KKnKL=hfnskfFJGQJEbtb3=i=Q@mail.gmail.com>
From:   Carlo Pisani <carlojpisani@gmail.com>
Date:   Mon, 13 May 2019 17:10:13 +0200
Message-ID: <CA+QBN9CN=n556f0KYj2LZ4q9wY+wx9mbWpaMcC44GufUqbsgEg@mail.gmail.com>
Subject: Re: C3600, sata controller
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, good news!
after a burn-in test of 8hours, we can affirm that Adaptec 1210SA does work
The chip is "Silicon Image Sil31122", so the kernel module is
"sata_sil" (not sata_sil24)

while [ 1 ]
do
for item in `ls *.bin`
    do
        rm -f $copy.out
        echo -n "$item ... "
        mycp $item $copy.out
        echo "done"
    done
done

*.bin are giant files, 1GB, 2GB, 4GB, 8GB, 16GB, 32GB

it has been tested on a PCI 32bit lost of a C3600
with kernel /v4.16!!!

"mycp" does a copy and then checks the md5 checksum

I think this card can be added to the list!

Our list has been already updated
http://www.downthebunker.com/reloaded/space/viewtopic.php?f=50&p=1632
