Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12715CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27C5222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=digitalsocialweb-com.20150623.gappssmtp.com header.i=@digitalsocialweb-com.20150623.gappssmtp.com header.b="TyEQEU94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632927AbfJYN7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:59:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33756 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505705AbfJYN7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:59:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id a22so2880934ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalsocialweb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:reply-to:to:subject:content-transfer-encoding
         :date:message-id;
        bh=BIrXkQbz0VOKYBZ72WJMNAib3nvrsy3PYgyT1Ms+edA=;
        b=TyEQEU94d1/B6cdSlaMb+pF22gJrFGiSFogZhiEHW++m8p1+4uXsjo5x/X9h4MyiOl
         p05QeiNpCfmEaUAUzI69hxLpn4ddW9T+fKQDS4+lYooQuArwbr/8nmn1jGJFfIRDD2Jr
         U0BkdEnj/e5IStkwuweYnv83xDwh20QVkJFQ4sp8olNfVyhfqTUO4DHZu1jD86U7OGNO
         J0QUR6s4Ncm75z6tLitbRtAiVHifL2ZOPioqmjNyxpEMOPL0gBpT4llhNLmdBWECyvez
         JZGTdNCnNdrzduJES/z7kSpxkhatH7ckgCL2t3fo6nDTn3kC9KBvSTCtxuIbOYweCFQk
         +PyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:reply-to:to:subject
         :content-transfer-encoding:date:message-id;
        bh=BIrXkQbz0VOKYBZ72WJMNAib3nvrsy3PYgyT1Ms+edA=;
        b=Nqi13/1URE8pLV6D6XGWwCnvxK/nKjXJbT71DXR80FiDtLuevEeg3ULomyO7bACXc1
         qejAAddy5eIM49Wacd5wct5q/BPEI/8xADI7xVWkPptxMt/NFiItPK9kJxyCXZu3XHYw
         h7aOoXf5OB1tNgeYroSLGZpVTn5lzPVT1s3q4zTIwVCzsytI27+AfE8Lyf/25cmdRR9K
         Oy93cEpTgNMTdpZY7o4dmyvh9IXCwgniFstVGPqT+Um0odXGEm62XoS8U9iZOl9Hek8V
         6qnWatbFPtDN3CEToW/qlBB8yM7gCileI/ufHVXc+ctG6qk7ctTLf2DG/y1+bZNs9pCb
         7wYw==
X-Gm-Message-State: APjAAAWV1SpQ8eIYFmW3R7g0CD/dmZQIrmi96QwKK8FVpkYLzUqA0Zdp
        O09IQ4jY7MjNTgvUjX/MT+C3pCyLyfo=
X-Google-Smtp-Source: APXvYqwywo3woV9+nN5vXnirm1Nv5GbLNzgdbvaAFUOJHSzOrK2CJRDVgP5l+agHLMCl6GcNQSN9wQ==
X-Received: by 2002:a2e:9dca:: with SMTP id x10mr2326834ljj.112.1572011942762;
        Fri, 25 Oct 2019 06:59:02 -0700 (PDT)
Received: from 72.255.54.232 ([72.255.54.232])
        by smtp.gmail.com with ESMTPSA id k7sm764879lja.19.2019.10.25.06.59.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 25 Oct 2019 06:59:02 -0700 (PDT)
MIME-Version: 1.0
From:   "Gabriel Gonser" <gabriel@digitalsocialweb.com>
Reply-To: gabriel@digitalsocialweb.com
To:     linux-kernel@vger.kernel.org
Subject: Paid Advertisement Request.
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Mailer: Smart_Send_3_1_6
Date:   Fri, 25 Oct 2019 18:58:57 +0500
Message-ID: <53924095274721899428561@DESKTOP-L09MN1Q>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

=0AWe are a Guest Posting services provider and found your blog during our =
outreach campaign.
We can do a long-term relationship if you can allow us to post a unique, go=
od quality and non-promotional articles on your website.=A0
=0AWe have a team of US and UK native writers to research and write quality=
 articles that fit your blog niche.
=0APlease let me know the price per guest post on your website; we can pay =
you via PayPal for publishing unique articles on your website with one anch=
or website.=A0=0AWill be waiting to have your very positive response!=A0
=0A
Best Regards,
=0A
Jason Dunlap.
