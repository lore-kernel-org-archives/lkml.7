Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F4BC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 18:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0A82087E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 18:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbfJLShV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 14:37:21 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:8523 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727423AbfJLShV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 14:37:21 -0400
X-IronPort-AV: E=Sophos;i="5.67,288,1566856800"; 
   d="scan'208";a="322499662"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2019 20:37:19 +0200
Date:   Sat, 12 Oct 2019 20:37:18 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Wambui Karuga <wambui.karugax@gmail.com>
cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2 3/5] staging: octeon: remove typedef
 declaration for cvmx_fau_reg_32
In-Reply-To: <b7216f423d8e06b2ed7ac2df643a9215cd95be32.1570821661.git.wambui.karugax@gmail.com>
Message-ID: <alpine.DEB.2.21.1910122035380.3049@hadrien>
References: <cover.1570821661.git.wambui.karugax@gmail.com> <b7216f423d8e06b2ed7ac2df643a9215cd95be32.1570821661.git.wambui.karugax@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 12 Oct 2019, Wambui Karuga wrote:

> Remove typedef declaration for enum cvmx_fau_reg_32.
> Also replace its previous uses with new declaration format.
> Issue found by checkpatch.pl
>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  drivers/staging/octeon/octeon-stubs.h | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> index 0991be329139..40f0cfee0dff 100644
> --- a/drivers/staging/octeon/octeon-stubs.h
> +++ b/drivers/staging/octeon/octeon-stubs.h
> @@ -201,9 +201,9 @@ union cvmx_helper_link_info {
>  	} s;
>  };
>
> -typedef enum {
> +enum cvmx_fau_reg_32 {
>  	CVMX_FAU_REG_32_START	= 0,
> -} cvmx_fau_reg_32_t;
> +};
>
>  typedef enum {
>  	CVMX_FAU_OP_SIZE_8 = 0,
> @@ -1178,16 +1178,18 @@ union cvmx_gmxx_rxx_rx_inbnd {
>  	} s;
>  };
>
> -static inline int32_t cvmx_fau_fetch_and_add32(cvmx_fau_reg_32_t reg,
> +static inline int32_t cvmx_fau_fetch_and_add32(enum cvmx_fau_reg_32 reg,
>  					       int32_t value)

These int32_t's don't look very desirable either.  If there is only one
possible definition, you can just replace it by what it is defined to be.

julia

>  {
>  	return value;
>  }
>
> -static inline void cvmx_fau_atomic_add32(cvmx_fau_reg_32_t reg, int32_t value)
> +static inline void cvmx_fau_atomic_add32(enum cvmx_fau_reg_32 reg,
> +					 int32_t value)
>  { }
>
> -static inline void cvmx_fau_atomic_write32(cvmx_fau_reg_32_t reg, int32_t value)
> +static inline void cvmx_fau_atomic_write32(enum cvmx_fau_reg_32 reg,
> +					   int32_t value)
>  { }
>
>  static inline uint64_t cvmx_scratch_read64(uint64_t address)
> @@ -1364,7 +1366,7 @@ static inline int cvmx_spi_restart_interface(int interface,
>  }
>
>  static inline void cvmx_fau_async_fetch_and_add32(uint64_t scraddr,
> -						  cvmx_fau_reg_32_t reg,
> +						  enum cvmx_fau_reg_32 reg,
>  						  int32_t value)
>  { }
>
> --
> 2.23.0
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/b7216f423d8e06b2ed7ac2df643a9215cd95be32.1570821661.git.wambui.karugax%40gmail.com.
>
