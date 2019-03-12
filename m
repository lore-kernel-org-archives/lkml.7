Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BA1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD987214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="n6SqDRO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfCLE5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 00:57:08 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:51742 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfCLE5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 00:57:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id B23D05B0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:57:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xUsb5Qg_d3Ov for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 23:57:06 -0500 (CDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 57ADE73A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 23:57:06 -0500 (CDT)
Received: by mail-pf1-f200.google.com with SMTP id w16so1701323pfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 21:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9x3ytMjHcqJl7R9Wmlj94eGZXd0inWNBSdMHQ10cvBY=;
        b=n6SqDRO7i0FgrtIEAgazzcOBpmQZAiTZThQr36ljbh+GsySwnKOjfialxUuYT8dR86
         U3SdgeQj4s94V5HZcKHyAEo2VW2gkbil3NZMtxAYjB1/PAnhFnZK3gn8WM+Q3YAL626S
         3qYirB8mm6t87x054aupIWj2YT4xAbpLwqKzdsaPRhAyzEUBQPOs8DG17Ac5o9rbQoar
         TkalurPg5gWl6RuY7wg2vI8joQw6Tq/c9hCDksMsEObL5F94K4xLUWwf/yKvAFVrk+m7
         PBTrDNxV4MJw9Zfu9haNPuOzmnBvuud37PRY33tHKQG7LKc4wThByQaZU6Qw8dnvFExC
         BTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9x3ytMjHcqJl7R9Wmlj94eGZXd0inWNBSdMHQ10cvBY=;
        b=r5Lz8h20TQamVRosr8EC0F58piQNzlIJnQBd5BiwbXkkrhfXHv8arTn1tbUkD4dA3l
         BLkDuHt0Nc0eHBmEy1igfm7Jd6ImA5kgmw027ACQ24T8FHRHP0S33hvFhUhraRrvq7U4
         vvfCbb4OfO8+8R7PP1MwoG8PteNPtf2h+nWYQ+ND/hiIKvB0sh5ahWdjYJqowUeiAef9
         OMpZSvIIUbZl3lS4OVDOLPdZxqE8CGqBrmzFMY5e1xM0rBP64Vvi16Wq74fHzF6Cy1ns
         pFmSNVet0Ba551/rfDlWEtju+tqWcMF1U1dr4KTWoN0Wi7H6d1Eqw+RkGwS9MGBRjcbe
         OEnA==
X-Gm-Message-State: APjAAAUwL3WxEvnVWQhrvll8sxkNl3kMZnKdNulsiDbTliYhsQQEKOf+
        uvuu1pkkVx7UOFFymM5ugn8J9zKoSNdpdQSvwcQuKz8UGMERM8xfug1hOmE6WA9TyP9c+pz1VmV
        xUbbDjRTauVu++BXXlPhMiqvDB+Vp
X-Received: by 2002:a63:6a08:: with SMTP id f8mr33664542pgc.165.1552366625415;
        Mon, 11 Mar 2019 21:57:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwf5oYqeYBMm0A/6gXQgFRlzoKKuCvmUm7PDTOFmL5ylNkevte2KXjcidRuA0yb7dj9EoPCRQ==
X-Received: by 2002:a63:6a08:: with SMTP id f8mr33664522pgc.165.1552366625088;
        Mon, 11 Mar 2019 21:57:05 -0700 (PDT)
Received: from [10.184.4.132] (host-173-230-104-21.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.21])
        by smtp.gmail.com with ESMTPSA id q86sm21481477pfi.171.2019.03.11.21.57.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 21:57:04 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] net: fjes: fix potential NULL pointer dereferences
From:   Kangjie Lu <kjlu@umn.edu>
In-Reply-To: <20190311.161910.28459399773636110.davem@davemloft.net>
Date:   Mon, 11 Mar 2019 23:56:24 -0500
Cc:     pakki001@umn.edu, colin.king@canonical.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B261BFF-1A3A-4EC1-B1CC-52404F709EC6@umn.edu>
References: <20190311071022.27610-1-kjlu@umn.edu>
 <20190311.161910.28459399773636110.davem@davemloft.net>
To:     David Miller <davem@davemloft.net>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 11, 2019, at 6:19 PM, David Miller <davem@davemloft.net> wrote:
>=20
> From: Kangjie Lu <kjlu@umn.edu>
> Date: Mon, 11 Mar 2019 02:10:21 -0500
>=20
>> 	adapter->control_wq =3D alloc_workqueue(DRV_NAME "/control",
>> 					      WQ_MEM_RECLAIM, 0);
>> +	if (!adapter->control_wq) {
>> +		err =3D -ENOMEM;
>> +		goto err_free_netdev;
>> +	}
>=20
> This error path leaks adapter->txrx_wq.

The following code also has an error-handling case: goto =
err_free_netdev.
Shouldn=E2=80=99t the resource release be in err_free_netdev?

>=20

