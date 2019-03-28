Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A109CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D462075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sk6U4aPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfC1B44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 21:56:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38719 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfC1B4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 21:56:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id e80so16874491ote.5;
        Wed, 27 Mar 2019 18:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G9RXxZWKQwBF5Mo/ZnrlsbGRsQJg13azRTg0miMtecM=;
        b=sk6U4aPx3EPMOHDnVEytFLnDR/Z5Zyp62RIeSTCJS6VBA3eC4b1b+bJDBC14OBFkLb
         8J5CBq/bBKzFT/4HdY7rUkhWGTFfOv/9XO7CDJ9ND0rsmgGatjew+ajm1gqmi54huGJS
         A+CxR8q5vZehdYAywgjtTrkVbZUvCr3rxjsaLEJ0JGdJIK9Exd4/nMDYcCj2GB9M0VCz
         BS+l/coy1Ehv+ukMh9IDwBN+6UGCjrUAAt3ACCMGZ2uTufjBwUW2w6/PWT7peVAZvDkY
         +87UNAuIYEM16uS4XA8ZRo0+gcs2TLB2XEY7SKSixnOrXhTgnYfJNwksdm+Xi+bpy/6t
         Y27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G9RXxZWKQwBF5Mo/ZnrlsbGRsQJg13azRTg0miMtecM=;
        b=JAzGy5+IgE8OhSolZZEFMNvJHnhzytaqmSIqmcP9jjx3ncsspOA7/nFybsy3YdoFJ+
         0DnRLZ40Q8OhGJS7KsuHYY4tYljVoMBciRx46Ucl5HA3G8y2eOYEBXo2DpqK3DgZq6KP
         B8jr8UBAMnoFjmMzSBtOeVg2DUJ4Pmns4iwxOiGs5ih81o8+7ucbKWLpLCVg2aNijBH1
         XOCKakSY+pYYvO5ozWQlkjbyCVGJaoq8wAi0dv4UaZjyjTtkeurwDA0PxnfzZw7qvNGP
         bzyQJ0FyP9yncrUVAB1OyfPcTjORf7+BCrGysVoWeqWXxSQDrEvFeIcE/Cugbak5RYUB
         eLiQ==
X-Gm-Message-State: APjAAAXZiuNXzT9/2veuP6gLN0FoDIVF0JeQ7jDXpCu/UdEsgO2en8vX
        0dXKxG0IDsSlG/ietIE0X+G76vfv
X-Google-Smtp-Source: APXvYqwAKV1J8HgJ8toEugxGBK15vnZoFigoThyJbCdHKEPBaz9cyH2QvVakgMLEk3g6y9eAsNiOoQ==
X-Received: by 2002:a9d:6d05:: with SMTP id o5mr29651375otp.175.1553738214449;
        Wed, 27 Mar 2019 18:56:54 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id q6sm9057903oia.4.2019.03.27.18.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 18:56:53 -0700 (PDT)
Subject: Re: [PATCH net-next v5 02/22] netlink: introduce nla_put_bitfield32()
To:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
References: <cover.1553532199.git.mkubecek@suse.cz>
 <94ec4068f6767acabf6bd795818f5b7ce2dae00b.1553532199.git.mkubecek@suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <abb1cd00-8e9d-938c-5263-0c400c3cf27b@gmail.com>
Date:   Wed, 27 Mar 2019 18:56:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <94ec4068f6767acabf6bd795818f5b7ce2dae00b.1553532199.git.mkubecek@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2019 10:08 AM, Michal Kubecek wrote:
> Similar to other data types, this helper puts NLA_BITFIELD32 attribute into
> a netlink message. It takes separate value and selector arguments, if there
> is a struct nla_bitfield32 already, one can use nla_put().
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
