Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172AAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9CD2133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552976079;
	bh=5sbE827tg+ZWwofJp/qDuF8JZfq7umv1xRsacUOjDhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=P2v7oYjkXG16zIB6yNQPC+qJUIL/DfI16CRn85qn8+VYmF66U3DWKQLc7Bhrcxz2t
	 eiAaxlUX5ixMlbnx8ZMeKHSXbL+4BcGU8LZWS1ZplU9xxlLby/7Hqn4nXdG1TpOAGQ
	 FzD0DVYVvQpUvQdt8mWYF0axvr0/wX6CXjEj1iXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfCSGOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:14:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfCSGOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:14:37 -0400
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0AA920854;
        Tue, 19 Mar 2019 06:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552976077;
        bh=5sbE827tg+ZWwofJp/qDuF8JZfq7umv1xRsacUOjDhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=j/DhXWCI7q3IbKRzEEHEqO/9VfcOnpCG2j7OqMz58C0n2CuQNtzG9krwC5hjwaP/O
         Ghzt/oTxfWBz4BK+KDWu5kQSi4YBZKwwZVotAQWks1OPQ2oTVy0njrSTAEn0bkxBOg
         ai154EjiHSAqs8Q68DmMSScLEdevhe5tRwySd7vM=
Date:   Tue, 19 Mar 2019 08:14:31 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Aditya Pakki <pakki001@umn.edu>,
        Boris Pismeny <borisp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Cc:     kjlu@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Wei Yongjun <weiyongjun1@huawei.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mlx5: Add a missing check on idr_find
Message-ID: <20190319061431.GL4823@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Content-Disposition: inline
In-Reply-To: <20190318221924.7034-1-pakki001@umn.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2019 at 05:18:51PM -0500, Aditya Pakki wrote:
> idr_find() can return a NULL value to 'flow' which is used without a check.
> The patch adds a check to avoid potential NULL pointer dereference.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
> index 5cf5f2a9d51f..3df468acdffc 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
> @@ -226,6 +226,8 @@ int mlx5_fpga_tls_resync_rx(struct mlx5_core_dev *mdev, u32 handle, u32 seq,
>  	rcu_read_lock();
>  	flow = idr_find(&mdev->fpga->tls->rx_idr, ntohl(handle));
>  	rcu_read_unlock();
> +	if (!flow)
> +		return -EINVAL;

It is wrong and whole function is wrong too.
In such case, you will leak "buf" allocated above.

The function mlx5_fpga_sbu_conn_sendmsg() which is used below can fail
and it will leave "buf" unfreed too.

Thanks


>  	mlx5_fpga_tls_flow_to_cmd(flow, cmd);
>
>  	MLX5_SET(tls_cmd, cmd, swid, ntohl(handle));
> --
> 2.17.1
>

--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJckIjHAAoJEORje4g2clin+iIQAI6aublc3HGEI5E/b4t52jAG
pQTUj1oD9JEMzwc3LxmjuVVF3Lmmj9iRbY7Svq7Q9eMVIe3L8z5Wo2AMcgwN1jJL
IX3Ap9IPwnV35qj9jeFGfb/EyiuEvu4HbeBLQL+DsyYGhJzl1WOgAF0Qr6GLpfma
95f4+ySbbPRU/cH8vu13asGGPqJvkqKYiSyTAzxUlZTivl1Xjoe3zC+Cwh3aFxr/
UahAJN1qZX/7IBJ8qSq9D5iHoJt+ODwmdEQm2HYppeUC+nFuWOmXh/UylDw9JPDh
5ZLh4aZxqViggE0jRQY/LzhBGLgb4v+8/A1B4Mmtv6NbE7nKnWvsQpd7exvA+a84
PPrvLP7PY7oWdEiN6hl2SRHjN/Jx5FniD6zJcLmxumk7vEHlut6sodFGCsxohExZ
E/HbIXLLIfoUuW/RBUEDHmDI9KLMM+a1tZ/tTWbr+5jAe+9poIhLZ/iXZj02CUNE
ZS0nsfkebg7hj7fGICnYD4TaAWvvyIDfhtarJ3zP0xYTNK93S+KEpUBCuqAD9C58
hFpUX2swbdzAfNmfraXm2uQo8kQQ5l65vjKZZkiFftJGBl8C4vNgh5kWOQg3pgAU
GqNrDVHaTJ/xY2s3g7iM+oOZ3RPPTVEkBvr5Ibhkabrdl9FGL+THiKQ+JN/AYmc5
nhzqw5UciZW82vo7fja1
=nczu
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--
