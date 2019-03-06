Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FB4C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63D620663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfCFQrv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:47:51 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42133 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCFQrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:47:51 -0500
Received: from rettich.hi.pengutronix.de ([2001:67c:670:100:1d::c3] helo=rettich)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jlu@pengutronix.de>)
        id 1h1Zht-0003qt-OM; Wed, 06 Mar 2019 17:47:49 +0100
Received: from jlu by rettich with local (Exim 4.89)
        (envelope-from <jlu@pengutronix.de>)
        id 1h1Zhq-0002Je-NX; Wed, 06 Mar 2019 17:47:46 +0100
Message-ID: <1551890866.5086.125.camel@pengutronix.de>
Subject: Re: [RFC PATCH 0/2] Create CAAM HW key in linux keyring and use in
 dmcrypt
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Franck LENORMAND <franck.lenormand@nxp.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc:     horia.geanta@nxp.com, silvano.dininno@nxp.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com,
        David Gstir <david@sigma-star.at>
Date:   Wed, 06 Mar 2019 17:47:46 +0100
In-Reply-To: <1551456599-10603-1-git-send-email-franck.lenormand@nxp.com>
References: <1551456599-10603-1-git-send-email-franck.lenormand@nxp.com>
Organization: Pengutronix
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c3
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Franck,

thanks for working on this!

On Fri, 2019-03-01 at 17:09 +0100, Franck LENORMAND wrote:
> The creation of such structures and its use was not exposed to userspace so
> it was complicated to use and required custom development. We would like to
> ease this using interface which are known and used:
>  - Linux key retention service : Allow to generate or load keys in a
>         keyring which can be used by applications.
>  - dm-crypt : device mapper allowing to encrypt data.
> 
> The capacity to generate or load keys already available in the Linux key
> retention service does not allows to exploit CAAM capabilities hence we
> need to create a new key_type. The new key type "caam_tk" allows to:
>  - Create a black key from random
>  - Create a black key from a red key
>  - Load a black blob to retrieve the black key

On 2018-07-23, Udit Agarwal <udit.agarwal@nxp.com> sent a series which
seems related to this:
[PATCH v2 1/2] security/keys/secure_key: Adds the secure key support
based on CAAM.
[PATCH v2 2/2] encrypted_keys: Adds support for secure key-type as
master key.

Is this series intended to continue that work and cover the same uses-
cases? 

If I remember correctly, the CAAM also supports marking blobs to allow
or disallow exporting the encapsulated key from the hardware. Or is
this unneeded and we could encrypt/decrypt other (less critical) key
material against the tk(cbc(aes)) CAAM key via the keyring mechanisms?

Best regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
