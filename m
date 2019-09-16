Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CDFC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F487206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fa462Rcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388840AbfIPVEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:04:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50366 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730662AbfIPVEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568667878;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yoztt8L8+kYQRxMPtC85ya3BagHgDeduD2h1ZIAKqTc=;
        b=fa462Rcc/kNO+Yrfm65UHYX0myr2VA+yUJL8rLC0QG4tXUMBhk7nOctb3zprfTroqCwBMu
        +QJLGrPoU42UQ0A79OdElBDGbS6WDbGy0xQHGUjNMrz377k3A2jOrvSlchosHVmudAHAFM
        vzukvQ8h1ZMOuw41JPAhUztXfTscx8U=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-Nyf1IN7zML2QvjYOJVRBGg-1; Mon, 16 Sep 2019 17:03:34 -0400
Received: by mail-qt1-f197.google.com with SMTP id g16so1699055qtq.15
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 14:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=BKNnujlsu7uye1NQvdtsoIEI5OprfE1Gweft1aGgxzQ=;
        b=JuM15ra3oT9OiZ8rRK8k42Xz0DmnKXSpRDdJe1aN2eeubcvgK9/ntfuUWq17DnbGFC
         KU++PZoWL8i0zDlhOG3VQrXPGyNX+o8ChMrlUJKV9qB8CROM2m87ghm0UAv8FB4R42p3
         d+xZA6rcYSiWYXI7hYrbmiiQ0Bt0BAZPDbdpoJDXNNsscJum5tR+Ewt9nn6XDnUToinb
         OVFFe/flHfH5Z+s62IlUr9qF07g3IJKWkOBa7P4UYXwxRlATvJNP/Ph2etDU2ntzh3qd
         l+dbMW5u/Prhfyk4Vdl1E1q3E/l4mC1fRUznYnV3KgL+lsGFLhnei4NwjVTlPfZd7CUO
         F6qA==
X-Gm-Message-State: APjAAAVfHn53WuF/7hNg2REnVL8937ZRwbmAVwxFFZOPYwqUmP9a2yuw
        GNJhzo7EuoEA8qExT6zUdF5IgQS0AnyxNEfZYKnx1zSEHIoG2ZBMP531LA/+oU4Bygp+7SGQFCj
        LTaB1y6RgAMD5wmnxaWr1GFtO
X-Received: by 2002:ac8:33c3:: with SMTP id d3mr393362qtb.41.1568667813949;
        Mon, 16 Sep 2019 14:03:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxpQBB0hj2oaAzIGQjzBEgm3XQZHAPhewba41ewLeoppALXlTPdv580wJU2vy2IMPPQEnjBkg==
X-Received: by 2002:ac8:33c3:: with SMTP id d3mr393327qtb.41.1568667813686;
        Mon, 16 Sep 2019 14:03:33 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id k17sm176571qtk.7.2019.09.16.14.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 14:03:32 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:03:31 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Wrap the buffer from the caller to tpm_buf in
 tpm_send()
Message-ID: <20190916210331.l6enypnafk2cwako@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190916085008.22239-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20190916085008.22239-1-jarkko.sakkinen@linux.intel.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: Nyf1IN7zML2QvjYOJVRBGg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Sep 16 19, Jarkko Sakkinen wrote:
>tpm_send() does not give anymore the result back to the caller. This
>would require another memcpy(), which kind of tells that the whole
>approach is somewhat broken. Instead, as Mimi suggested, this commit
>just wraps the data to the tpm_buf, and thus the result will not go to
>the garbage.
>
>Obviously this assumes from the caller that it passes large enough
>buffer, which makes the whole API somewhat broken because it could be
>different size than @buflen but since trusted keys is the only module
>using this API right now I think that this fix is sufficient for the
>moment.
>
>In the near future the plan is to replace the parameters with a tpm_buf
>created by the caller.
>
>Reported-by: Mimi Zohar <zohar@linux.ibm.com>
>Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>Cc: stable@vger.kernel.org
>Fixes: 412eb585587a ("use tpm_buf in tpm_transmit_cmd() as the IO paramete=
r")
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>---
> drivers/char/tpm/tpm-interface.c | 8 ++------
> 1 file changed, 2 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-inter=
face.c
>index d9ace5480665..2459d36dd8cc 100644
>--- a/drivers/char/tpm/tpm-interface.c
>+++ b/drivers/char/tpm/tpm-interface.c
>@@ -358,13 +358,9 @@ int tpm_send(struct tpm_chip *chip, void *cmd, size_t=
 buflen)
> =09if (!chip)
> =09=09return -ENODEV;
>
>-=09rc =3D tpm_buf_init(&buf, 0, 0);
>-=09if (rc)
>-=09=09goto out;
>-
>-=09memcpy(buf.data, cmd, buflen);
>+=09buf.data =3D cmd;
> =09rc =3D tpm_transmit_cmd(chip, &buf, 0, "attempting to a send a command=
");
>-=09tpm_buf_destroy(&buf);
>+
> out:
> =09tpm_put_ops(chip);
> =09return rc;
>--=20
>2.20.1
>

Nothing uses the out label any longer so it should be dropped as well, but =
other than that...

Acked-by: Jerry Snitselaar <jsnitsel@redhat.com>

