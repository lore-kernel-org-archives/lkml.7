Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B06C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B816A2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="aD6nZR0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfCLF1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:27:01 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:59002 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCLF1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:27:00 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 13A97A05
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 05:26:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k0dLo4k6Sx_3 for <linux-kernel@vger.kernel.org>;
        Tue, 12 Mar 2019 00:26:58 -0500 (CDT)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id C8124943
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:26:58 -0500 (CDT)
Received: by mail-pf1-f197.google.com with SMTP id u19so1782487pfn.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8JhHNdae3phpGSf32QxV0mOG2QImn02s16CM2Kb6KMM=;
        b=aD6nZR0dNvdDa1sDZWfb2snxHs7HS0+mCrHwOtt9f68nHZxQ4hNnSc3GcJ5DZujvpv
         fXyLDNbHym5oMrDeC0BvZG35Sj6bQBka1CkPvTSU77LbYCvPLsefswejlb8fz/OYom59
         25PbDtGDB3Qoqzo21E5zNbLEUTEaUkghvTgGGKuuVg/9sZGPe4wPW2pYZ2w+LhePq7iY
         8gr2FYyYgX9c5leu09dIEe+U4QifGcWLTYqnv1B4lgcDJknvp19ppt8BjVie814v7kUo
         zfA60zg72Jp2gQej8WtwJW4syHfGgqdVpMOuphBOAj7Ue+X2exmKdQj6OypKC85qWJdZ
         y5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8JhHNdae3phpGSf32QxV0mOG2QImn02s16CM2Kb6KMM=;
        b=sxVYd721KWbh2fUxDkUSLQTQtntE6HSCk4WG9dDbgB/EBL+9HlbVBp974zjP469Cmk
         wzwzBQeB1dyVADM2bic6s8Bili3am1IXol7liAV5hy07UJTOwwXc808FTx5NAoDcVwE2
         MXEIjP+9XMXeP8cpodHy6dOSoBii+4LJ7kSVjxKMFJFaVSDywKTC6KjdR6+/+tX0H08+
         HlSaUVj/G+eVOL3auYf4m3KQH2p+PBNd9nVvHH23LVhQIo4KpxRljxDmTnaxBHDGgDaa
         vrkuWT2yrNsIgvK4z+lrlL7frmrXCEriM5qhbkNJVPDFOmiD9y2fIV/UR5HUYpRrCWu7
         3DKg==
X-Gm-Message-State: APjAAAUDdWWu0hu4jNa1lKNpo0OeMpvjdO5M1ScCwzC+FEZWyzlHxEBc
        b3NK+yqLXI0HN1ZHf/btBF6VBSyhvju2gGZiH83pIPYJ8gqiqFAQ/Wq0U6qVunu/oCG3Y/oYq5r
        N2pbmbSl4o1N60Rzjjkb2L4/0s2I8
X-Received: by 2002:a63:d4f:: with SMTP id 15mr33493754pgn.162.1552368418187;
        Mon, 11 Mar 2019 22:26:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzndS8W1g5A3c9B7ZNV0W8LF5g0rcJkJwCwRvt8yUhKgCOw0XmP1pV0GVcZVYteHCebrPTE0w==
X-Received: by 2002:a63:d4f:: with SMTP id 15mr33493743pgn.162.1552368417846;
        Mon, 11 Mar 2019 22:26:57 -0700 (PDT)
Received: from [10.184.4.132] (host-173-230-104-21.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.21])
        by smtp.gmail.com with ESMTPSA id p78sm14581571pfa.84.2019.03.11.22.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 22:26:56 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] net: liquidio: fix NULL pointer dereferences
From:   Kangjie Lu <kjlu@umn.edu>
In-Reply-To: <20190311.121710.968693621648443243.davem@davemloft.net>
Date:   Tue, 12 Mar 2019 00:26:17 -0500
Cc:     pakki001@umn.edu, dchickles@marvell.com, sburla@marvell.com,
        fmanlunas@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A94F2FE5-9403-420E-ACBE-C9DF0BBEC35E@umn.edu>
References: <20190311054615.11760-1-kjlu@umn.edu>
 <20190311.121710.968693621648443243.davem@davemloft.net>
To:     David Miller <davem@davemloft.net>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 11, 2019, at 2:17 PM, David Miller <davem@davemloft.net> wrote:
>=20
> From: Kangjie Lu <kjlu@umn.edu>
> Date: Mon, 11 Mar 2019 00:46:15 -0500
>=20
>> @@ -1960,6 +1966,12 @@ static int setup_nic_devices(struct =
octeon_device *octeon_dev)
>> 		sc =3D (struct octeon_soft_command *)
>> 			octeon_alloc_soft_command(octeon_dev, data_size,
>> 						  resp_size, 0);
>> +		if (!sc) {
>> +			dev_err(&octeon_dev->pci_dev->dev,
>> +				"Failed to allocate =
octeon_soft_command\n");
>> +			return -ENOMEM;
>> +		}
>=20
> Again, very sloppy.  You have to branch to setup_nic_dev_free in this =
situation
> otherwise you leak devices allocated and setup from previous =
iterations of the
> loop this code is in.

I was referring to how the following code handles errors.=20
Does that mean that the returns at line 2004, 2012, and 2019 are also =
leaking=20
devices?

>=20

