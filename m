Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408F1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E655213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpOpiK9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfCSOZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:25:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34074 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfCSOZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:25:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id k2so22341781qtm.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 07:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BHr58bZTK/dW8lcPjGA4iNyjw75zsiEtuluqMZdQBi8=;
        b=MpOpiK9FdBWh9rzuSW9ybpDMsuqbEFaSOZWUzPo98kb84xMzbVlyGraOCNqzzRWyDz
         HKBb+PIcUN0B8BaCdk1JoloHc18APzxp0woA1c4avBb+T9w6r9AhzEZGZuUDz3ZIbhKA
         3tbV1HPUmOg25i1h/Kt/bubpvgsTiP5Sywe7fKw0fx6or5hbXaMzeAiJph/sJMupOLV9
         Xcq4tOWX5rx/WlgpLGAL83t2GUW64CuBdhUeqoOH9sNa7su5XovQaImTvvBiheog4YZM
         hV8JPiyvyc/ee2UBXa+4pY9YDikA8+mUkJ8+LRcA58+CmsmIiCqK6hshx+fzLYJYqar9
         reHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BHr58bZTK/dW8lcPjGA4iNyjw75zsiEtuluqMZdQBi8=;
        b=rY7CN+BsRl2VVh1zQUDWBMmVWHYlprHAtWtpbaP7SWUKBXKxYYuYc+HjpySGQ+S4gA
         DSysOI1bkHcoW9kg/c55tdtXPI6BQLJJ9BOVLaaZKvvvcEeu3ZMQr20BHmpYEizc/H4h
         S1ZJDpC7nQKJpYQuXVSzGuvvWf3EOFUVA8RndDl8t5vxTgQviXGBm9n4N17yh/eHHebe
         c66gzL4HNfyYwB3fc9jQ7c2QCMyra0wozw4GGxnKPek+2gvhhvArdUpfKWiDFohbw/+k
         xFnXx/z6kVs9AaEBPMAyKEU26SUzXdsJEXF0Ny/xkvBOYjzMBbXkV32NFhfJ6I6MDMvS
         u6oA==
X-Gm-Message-State: APjAAAUhO4nfm6sOVjz37Y/1NIvPY03UjT2/ZkY2/rumixz5xkzq1fLR
        t+0W6LOzvZHCDH9R49NnyuE=
X-Google-Smtp-Source: APXvYqycB/tI/vXqf282ay8IUvNpHU13BzY5SaCdNiO4cTNmpK58Vp/FsYGEQr60nj/LuOg1PUoFrA==
X-Received: by 2002:ac8:2f98:: with SMTP id l24mr2214895qta.261.1553005552158;
        Tue, 19 Mar 2019 07:25:52 -0700 (PDT)
Received: from jfdmac.sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id s17sm7009508qtc.15.2019.03.19.07.25.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 07:25:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/2] w1: ds2408: add a missing reset when retrying in
 output_write()
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
In-Reply-To: <DF2ABF87-116D-4287-8A18-89C2C59124AF@gmail.com>
Date:   Tue, 19 Mar 2019 10:25:50 -0400
Cc:     open list <linux-kernel@vger.kernel.org>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <greg@kroah.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3E9B4A8B-6409-4102-A3A2-40853AD04DB1@gmail.com>
References: <20190318092737.8170-1-manio@skyboo.net>
 <20190318092737.8170-2-manio@skyboo.net>
 <DF2ABF87-116D-4287-8A18-89C2C59124AF@gmail.com>
To:     Mariusz Bialonczyk <manio@skyboo.net>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 19, 2019, at 10:21, Jean-Francois Dagenais =
<jeff.dagenais@gmail.com> wrote:
>=20
> I can do a proper patch submission if you guys provide positive =
response on this
> early RFC. Or better yet, you can take it and own it yourself as your =
v2
> Mariusz. ;)

Just FYI, here's what the retry loop looks like after this suggested =
patch:

	do {
		w1_buf[0] =3D W1_F29_FUNC_CHANN_ACCESS_WRITE;
		w1_buf[1] =3D *buf;
		w1_buf[2] =3D ~(*buf);
		w1_write_block(sl->master, w1_buf, 3);

		readBack =3D w1_read_8(sl->master);

		if (readBack =3D=3D W1_F29_SUCCESS_CONFIRM_BYTE &&
		    optional_read_back_valid(sl, *buf)) {
			bytes_written =3D 1;
			goto out;
		}

		if (w1_reset_resume_command(sl->master))
			goto out; /* unrecoverable error */
		/* try again, the slave is ready for a command */
	} while (--retries);


Much better on the eyes.=
