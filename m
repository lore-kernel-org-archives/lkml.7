Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E8DC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EBC215A4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7SqmRt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgACRMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 12:12:34 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34128 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbgACRM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:12:27 -0500
Received: by mail-qv1-f65.google.com with SMTP id o18so16489055qvf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 09:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vV6a+3S2CgVP2zgllAWlmqvUviEk0ZUKB0VmFQup2MM=;
        b=q7SqmRt9svPc6WesbG64Tpx4gDTGEX4IrS83bOn2XC8YkU10kfQBqVN7caHtrQJwPs
         39C8hXjMIwxG4fINgl9nD+54tuIK1HA3tbxJB839znVN+ORUOp3UlarGBB6NWnAPsUrj
         JkELDqNjEAwJjiakOzCiZx+Z1EI8UBvrpvwF4hu3e2ji76fJQNdgdrboJODQ0PnCXvNy
         rEvf1B+KnUAMyeX4c/a8CLAdI5e+hvWx+xGc1zfn8KmLz9JNPn1Xr1aZN8GCpqpSv0tj
         6mCbSXd4TgiUS5GYBIg3GijK/SUKhWtIJYRqhuHTlRr2vNQ5NcvKrHVawXkc0bzV5sL1
         70fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vV6a+3S2CgVP2zgllAWlmqvUviEk0ZUKB0VmFQup2MM=;
        b=L5mfmR3yfLGG73KghKJ5SeCnd5B6EBfFOoetbmfjT5FenuHj2pl7RsSMg6I/rVpgR8
         qo4pixQrevj3O8u6QRKak7Ot0Ax0S3xtXAlmyHKVh2uWSNJm7P5knckmTSuaz7CBU7ib
         cVTWl6A/W3iYMwvnIAtOnDrNSFEfRpesCAzMFCuzZuPSKMR1PqRr2E54Oqnqce3AqA+c
         P7s0vIMqRE5bBxyRqVva3ZTP0w8on81JMJgjE/8yUFJSJzJlruNfE+oj2C9DyKVVtLyB
         LZRaybH+4pjH/UXdodvs+y3mQ9lq7Ec8dpV1OJy96NiCxOyv2C0ksQYta7RFbozdNF7M
         zkiw==
X-Gm-Message-State: APjAAAWLZiSA1C3XytOM8Vz72a1b8Mq+rPon6Vk6KZFyOgHS/h9MAyxq
        n82e2Ayo3KKPbY2RnDLHdOs=
X-Google-Smtp-Source: APXvYqx6Er3/Z0yocOThD/C83mCKegn2uS88qcp2Wo0KSp+6jt5479A3OtISRAReOEj+l8zXMPpDaw==
X-Received: by 2002:a05:6214:162c:: with SMTP id e12mr66843626qvw.3.1578071546080;
        Fri, 03 Jan 2020 09:12:26 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 17sm18990708qtz.85.2020.01.03.09.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 09:12:25 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 3 Jan 2020 12:12:24 -0500
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/24] Consolidate dummy_con initialization
Message-ID: <20200103171223.GA1308999@rani.riverdale.lan>
References: <20191218204002.30512-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191218204002.30512-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 03:39:38PM -0500, Arvind Sankar wrote:
> This series moves initialization of conswitchp to dummy_con into vt.c,
> and configures DUMMY_CONSOLE unconditionally when CONFIG_VT is enabled.
> 
> The patches after the second one remove conswitchp = &dummy_con; from
> the various architecture setup functions where it currently appears. If
> the first two look ok, I was thinking of sending the others
> individually.
> 

Hi Greg/Jiri, happy new year!

Are you able to look at this series?

https://lore.kernel.org/lkml/20191218214506.49252-1-nivedita@alum.mit.edu/
