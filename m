Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49046C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1798420675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjFWfCza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfCFCZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 21:25:35 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41351 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCFCZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 21:25:35 -0500
Received: by mail-qt1-f193.google.com with SMTP id v10so11234724qtp.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 18:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=inlvL6h8BBPdw6YSdCNIUxqA7naCUQMPpbxUU32LN7c=;
        b=VjFWfCza1FrBJS2z7OJ6IYNd3HjNUautEE6TrIMATQHWXEhOdX9ZuBfGN7wUJzuxiT
         7GxYgF8K4OsvcLivHZ27dfkPN812qlJ+0RR15jsef607mw0kiEj7ovitWcs2I6Z7ShC8
         cY84P+MkDrG8F0vfD7aTNYWW/K4s71gAfB207TcZ4nv8Eg5VJ4v8R6H36O3m6XA4ZbtM
         suYEri1wKBvphnkpHxz+wSpwleYFOCiS9XG7t6yn60vCbcubdHTvc2MgaFImn/LObqvS
         GCeAyEIrtCxtDb8fJM2+SlQmAqpB16c1txwb6MZFvKGtZHmMo7k9Qi1C1N/chMsknSHT
         a3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=inlvL6h8BBPdw6YSdCNIUxqA7naCUQMPpbxUU32LN7c=;
        b=qTmgOeGjUyQTPfmf0wfWPHY9XSd41++xgDE8yX3viK3YfkyOShEmLgoRGY3ZlVofpL
         uLPNBw9pfprgnh15LsxckCmokIeI3kC2goPfjq7QYr7mBX5JDIMG+uoXQLywfdNUcddF
         /EPfzqmvfxDHq++7DcpIRbMgk1XQWzehD6aAXkBpOjP9uu8VXhAk8pkbuTSkpcPqpYCZ
         Txi5SchvToNq1FpKIy9YcrLeMn1ELiFntc/+l/Sa5HSO98sXC5YbjlMoCw2AQiMCKdza
         kZPXfV8G9LMeOUuzR/KpWYVcruxZ3dXlNOyuRAj00FlyfOFqBHZMW46Lxvi/ksHui50a
         Gnpw==
X-Gm-Message-State: APjAAAXANc+NfpQmF6MjzoqLaNMEns5xdd98foAc2j5GCU10PG3yxWs3
        WaumgAPa0piVD9NSVfd1xdJYlRb/
X-Google-Smtp-Source: APXvYqxlcJdb4m6iCyAn9WzDKCCvgR1jbCxPfU3MCpEfRUxaR63c5V+MQQ/0b53Q4kTAm1Ly2SuxiA==
X-Received: by 2002:ac8:1c5d:: with SMTP id j29mr3921813qtk.113.1551839133759;
        Tue, 05 Mar 2019 18:25:33 -0800 (PST)
Received: from localhost.localdomain (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.36.129])
        by smtp.gmail.com with ESMTPSA id b142sm442204qka.74.2019.03.05.18.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 18:25:33 -0800 (PST)
Date:   Tue, 5 Mar 2019 21:25:31 -0500
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     linux-kernel@vger.kernel.org, axboe@kernel.dk
Cc:     xen-devel@lists.xenproject.org
Subject: [GIT PULL] (xen) stable/for-jens-5.1 to your 'for-5.1/block' branch.
Message-ID: <20190306022530.GC25368@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jens,

Apologies for doing it right at the merge window time. This patchset has been brewing
for quite a while.

git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git stable/for-jens-5.1

This patchset makes the backend more robust by reading a negotiation
variable only once and not twice.

Thank you!

 drivers/block/xen-blkback/xenbus.c | 99 ++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 42 deletions(-)

Dongli Zhang (2):
      xen/blkback: add stack variable 'blkif' in connect_ring()
      xen/blkback: rework connect_ring() to avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront


--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcfy+aAAoJEFKlDoTx2wm/L9EP/1hInhOLDpzp4j9svuArMEtf
2HbAezkSPcAXhhXr+yXCxrLYqZldxG00ohwQikogxugqDiPWGzR1NU+7FvmkUDg7
0EJAumsuTT/Ok7vNt0TlrNATKYvE2RQroOJ8KknNFA3vOXaN4WPaT/Qr0KIyJnli
10PgigQzvLvkbdXg91cZfVHLAcTVWp48FT0r2q/KFI1r0ehiOEzmdrB8bnZ9hxQ8
yvRFHBNEeHd2UGJpLZ2Cq6KwfDXae4GKW201n03QHN4obgI8tKjlZmDWZS52RK+Q
C+KaSlCVwISr4CMibWAsOJ3ChL/e/y7TB02MNDyF9EBS8przv3BjdLfPBEE4XUn1
EpAvNUGiV4TlCR0A4NEaJimcZD0pBBEFpyjX6ja2c1bEBu/iuCK8pgsg34NIze3k
XPcM/ovxesyOrBgCQ3E/QceiBHULYulTskv+vv67P6/DCie/Jcg2PD2YbxyKLq/M
DKk6VHJNRMl2CwiKx8EyIBD11vDd8WMWP86i/0GSqqh7ckV8C6MjgT8UtNgZDr21
wh+Efg3hgsC7d4XfbT9zu9uVMsMhSV+EzF1ajDXTBF1wsGmbwxkoMtqyejziitHZ
WntO/bAAfkbB3dXpUcS+XLhN4HIUXemfnZdDLCFxy9T2l7VMydswi7X5YlnyaxRt
ANzNPES7tCHFeNwGr8hW
=L583
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
