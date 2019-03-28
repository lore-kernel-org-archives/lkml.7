Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01481C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6D5204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Prcs9/fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfC1MRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:17:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43007 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1MRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:17:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id p20so22704653qtc.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 05:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=fDZS3vDMCOOiXbg9QqfTJX9pJw1cncHaCY8T2SVwpkY=;
        b=Prcs9/fdRFfz7mC6O4vQ/r90d/Tzq5UG7/XrKdv6igF4C3Lngo+v8VdVa3AKopxO8x
         aWl5wpIixJGbPFYsYXBWniEbZ9MPO6NToipVF1AGXLNyVYy7OvpKSmwIcfQYPI4hxt26
         qlq/C2VoZXON8lJrc+D+yeh3fyDIxMPTb1DVPdIxTmKAyKX1LjFZGRtjzScOW6pSoHFi
         Bo7fy+xWJrMFDgGI4zgWCGLrRC9ar5QKpW/6zDySTDpZHRIloWYVilvQYUzEW2zTB0pu
         BO4F4+h38NyjzN0QyCfgm3saFPaOtMKbSlM1+myExAhYH6TnKp4ikmH/29cdKfK/QJxJ
         dSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=fDZS3vDMCOOiXbg9QqfTJX9pJw1cncHaCY8T2SVwpkY=;
        b=GOTHCw1JzmTANNpQM4nIUDMsuY+PAusgnJNbwUyfJJSm+jt5qbNjyT1LZbbBDIRyQQ
         8GHoHY86rvdG7Q6hz18I0OPd1c8KqewIv2AfKIUO5LjQBmUytxAz9EJetcOzWeU4eL2T
         f8UKYxzJL+PcOqxRCtgPWZLDF3o/PWX1ZPGrP+ADEGg/5nJU8j9RnC9wC83ayAK6djRU
         IQTce3/Utu7ez7c8sxLm+lP9USQxvOwyFcaTnGdWfhIUUSIa4L0wCMWwQCTY6v3ZpaXa
         TxFDtrgKwiW993vJlU4ZxZmhLrKjjkQt3V9b0Ie0Ys5XzB821ZGg2zKB+PavPpDYZBPL
         V07Q==
X-Gm-Message-State: APjAAAXuiEM/dUuVbFqLc26MuMBlniQtXuPHndh697M7HGqvOKy+K4af
        NC6LJeQFpJ/EWhX031R1YTtB4XqT
X-Google-Smtp-Source: APXvYqzqFLolP58wMiyrejQBQL2EvPnMqEQf7laVjpUlx1BAbDOvHXkUixVtcvrdoKvN23K31oILGg==
X-Received: by 2002:aed:22bc:: with SMTP id p57mr36144257qtc.180.1553775470752;
        Thu, 28 Mar 2019 05:17:50 -0700 (PDT)
Received: from jfdmac.sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id s12sm4437263qke.36.2019.03.28.05.17.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 05:17:50 -0700 (PDT)
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2] w1: ds2408: reset on output_write retry with readback
Date:   Thu, 28 Mar 2019 08:17:49 -0400
References: <20190318092737.8170-1-manio@skyboo.net>
 <20190318092737.8170-2-manio@skyboo.net>
 <10244730-36A8-4DAC-95E5-AD7BDEA32F43@gmail.com>
 <20190327165317.GA3137@kroah.com>
To:     open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20190327165317.GA3137@kroah.com>
Message-Id: <49DF2FF4-FB5E-4FB8-94E3-BE14E5C2DEAF@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

** resending to list only because of bounce **


Hi Greg,

> On Mar 27, 2019, at 12:53, Greg Kroah-Hartman <greg@kroah.com> wrote:
>=20
> On Thu, Mar 21, 2019 at 11:18:27AM -0400, Jean-Francois Dagenais =
wrote:
>> Originally
>> Reported-by: Mariusz Bialonczyk <manio@skyboo.net>
>=20
> That needs to go down in the signed-off-by area.

Noted.

>=20
> Also, please resend this series in a way that I can apply it.  You
> didn't say what the order was for the v2 patches.

Mariusz can chime in but I believe although it was the same exercise =
that led to his discoveries, each patch can stand alone and be applied =
in any order.

I will send a v3 without a reply-to-id. Mariusz' patch "[PATCH v2] w1: =
fix the resume command API" can be applied as is unless you need it =
changed or resent.

Cheers!=
