Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED352C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 13:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92462075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 13:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfEBN1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 09:27:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38191 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfEBN1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 09:27:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id k16so3372922wrn.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 06:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klk9BfNLobZFzvvv3RWonkuC3y07XDsJxgsitF+PBMI=;
        b=gmpe2HtyeQhAsnZgpW5ozoN/vzAwwMdh5RnQDXwEvG7TongNKSdqe46+e87VRIBskF
         loqLKWVdKIlv5jS86zYPGnu6PhEpnGprj44OoaXk55I7hNJTNK61dbCuXBqk3CyOxmcN
         yRQ0muDq8pN0eckndkzeKw4SmLfNyTRmRy/QjQDKRFUvi2emKnSnptAo8Dk7nf+hdXhc
         lWfyk161u1rek4Z3NKbofW7ewlO5LxhjwaU3rD4aak8lEaKyVamaqu4mkw4u5gkB0zbc
         77jsyJ/UxOkMuq0si4wnaFaWowoaaemetcrHeDGzZbP5oVdnsHD6xYGZUVlCLV+JEyx2
         ZqHw==
X-Gm-Message-State: APjAAAXhP5SrbFa71m8MDOf4yGhLLeX5MUJjLL/hmU0yq8fOcI6MsUyG
        HhxX6/kcFdcQQCs3a+f7zK0XiUBwSUAswnbeKpaMew==
X-Google-Smtp-Source: APXvYqzwqgHiTGnc/CUv5ctBzIs+Lutqt2xj3BHihx/LSigv+LRUxs2dNE20e+3GgBpSacsfbpEzd2l4Oe6+XZAb8TE=
X-Received: by 2002:a5d:548d:: with SMTP id h13mr2948846wrv.218.1556803636210;
 Thu, 02 May 2019 06:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190501125717.5695-1-colin.king@canonical.com>
In-Reply-To: <20190501125717.5695-1-colin.king@canonical.com>
From:   Bryan Gurney <bgurney@redhat.com>
Date:   Thu, 2 May 2019 09:27:05 -0400
Message-ID: <CAHhmqcTRVWBNnynaAJ7mbtke-MCiBma-6z_=bYrFzh0ubky-Fw@mail.gmail.com>
Subject: Re: [PATCH][next] dm: remove redundant unsigned comparison to less
 than zero
To:     Colin King <colin.king@canonical.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 8:58 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Variable block is an unsigned long long hence the less than zero
> comparison is always false, hence it is redundant and can be removed.
>
> Addresses-Coverity: ("Unsigned compared against 0")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/md/dm-dust.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/dm-dust.c b/drivers/md/dm-dust.c
> index 178587bdc626..e739092bfc65 100644
> --- a/drivers/md/dm-dust.c
> +++ b/drivers/md/dm-dust.c
> @@ -411,7 +411,7 @@ static int dust_message(struct dm_target *ti, unsigned int argc, char **argv,
>
>                 block = tmp;
>                 sector_div(size, dd->sect_per_block);
> -               if (block > size || block < 0) {
> +               if (block > size) {
>                         DMERR("selected block value out of range");
>                         return result;
>                 }
> --
> 2.20.1
>

Thanks.

There was already a check before that to ensure that the argument
feeding this variable is an unsigned long long; if it isn't, it will
fail with EINVAL:

# dmsetup message -- dust1 0 queryblock -1
device-mapper: message ioctl on dust1  failed: Invalid argument
Command failed

Reviewed-by: Bryan Gurney <bgurney@redhat.com>
