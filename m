Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA31C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597432070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=reply2setup-com.20150623.gappssmtp.com header.i=@reply2setup-com.20150623.gappssmtp.com header.b="VkmZOKAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfKNRnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:43:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35633 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfKNRny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:43:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id q22so4239003pgk.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 09:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reply2setup-com.20150623.gappssmtp.com; s=20150623;
        h=to:subject:from:message-id:disposition-notification-to:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=AT6ku+cybKeH11LZiwN771me6TdCfWU44QMk7DxPZyY=;
        b=VkmZOKAoPbXKe5kQ0ILhjfxkiigETwY2f2+LIeoCtSMPtvSR5ANq2X/LufLepEfCX9
         T4Rq1EP7OgNRDqtC44Ojm7st+0uI6RBFQOMKzC9drvu5xT5mTsNn72J6CCjQw8Cal0IV
         BNA8D8mZA0FbentOQ2r6SmvSGqAseYd7L7PlDCaoSnsov89u3Xapjj0EjQU69gcfSN7q
         qxmOgYCUUBOTUbuaHQQhyKrespiubI4WRsUZSdKVhSOKbaPx6J9GQ5RuHc5U/wGxOpRH
         HLF+zYbyagTCSjyli/OH3w+C4oAdcDf72Y64CqjwzU1Ef776QMdlt0r1cBW7xhIauvBU
         oDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:subject:from:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=AT6ku+cybKeH11LZiwN771me6TdCfWU44QMk7DxPZyY=;
        b=k7g0GdsU9ULJAVHqgG6jgwsZ8OZ7K/Ll8RZ6HlO+O6/1SFPeBhjh63CidzdRLiygk5
         x/jhIopBxkxrNzsFo9jsOfGxjxpFV/K0AorFeBUDnLrm+YbDtMJeoUKWjWOdl2fG64FV
         7xUaIc0kSI35whpZ6FTZJW45Wi40d8enNUHD1Zg9oFuPFBugYKccPEXs2dJ+o33jyZcv
         GnWmfbRIro+/yV8b0J9706GKFIW8FLBrLcCDjpiAsizDW0Qqz9kGoaqaVn++F0OviqAl
         n6pY0U16c3FRAstj2LlcG57XojzwGUsTq2pC0FZ/jcMYIX79j6y170Dd5MA9YcrNxUMt
         45ZA==
X-Gm-Message-State: APjAAAUO/qmpnuqlfxYNXdrsVoqUxXsElWJKtSrieQma9km7eU8ISVgE
        h3GQBY5WSRIzEhIjZjInR83ahSUUlyw=
X-Google-Smtp-Source: APXvYqzHsTfnodV53wjd2HRaM3Vob7D3cwU/At844qGjrDx/M3wSFLTmVqy0bMc16Atvn2tygOuU6Q==
X-Received: by 2002:a62:5216:: with SMTP id g22mr11904387pfb.78.1573753434006;
        Thu, 14 Nov 2019 09:43:54 -0800 (PST)
Received: from [192.168.0.3] ([103.16.71.221])
        by smtp.gmail.com with ESMTPSA id y36sm6677250pgk.66.2019.11.14.09.43.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 09:43:53 -0800 (PST)
To:     linux-kernel@vger.kernel.org
Subject: Wine List
From:   Cheryl Edwards <cheryle@reply2setup.com>
Message-ID: <62c3d9aa-f29f-8d01-3dbc-cceaec273293@reply2setup.com>
Date:   Thu, 14 Nov 2019 11:41:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.3; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Antivirus: Avast (VPS 191113-8, 11/13/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Would you be interested in acquiring an email list of "Wine Enthusiasts" from USA?

We also have data for Beer Enthusiasts, Liquor Enthusiasts, Beverage Enthusiasts, Spa and Resort Visitors List, Food Enthusiasts, Entertainment Enthusiasts and many more.

Each record in the list contains Contact Name (First, Middle and Last Name), Mailing Address, List type and Opt-in email address.

Please let me know your thoughts towards procuring the Wine Enthusiasts List.

Best Regards,
Cheryl Edwards

We respect your privacy, if you do not wish to receive any further emails from our end, please reply with a subject “Remove”.

